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
    self.effectToTarget = def.effectToTarget
    self.effectToSelf = def.effectToSelf
    self.aoe = def.aoe
    self.effectPower = def.effectPower
    self.level = def.level
    self.playerCanImprove = def.playerCanImprove
    self.scale = def.scale
    self.require = def.require
    self.player = player
    self.cooldown = def.cooldown
    self.ready = true
    self.cooldownTimer = 0
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

function Spells:use(target)
    if self.ready then
        if self.aoe then

        else
            if self.effectToTarget then
                target:getDebuff{
                    status = self.effectToTarget,
                    duration = self.duration,
                    effectPower = self.effectPower + (self.level * self.effectPower + self.scale * self.mainStat) / self.duration
                }
            end
            if self.damage > 0 then
                target:takedamage(self.damage * self.level + self.scale * self.mainStat)
            end
            if self.effectToSelf then
                target:getDebuff{
                    status = self.effectToSelf,
                    duration = self.duration,
                    effectPower = self.effectPower + (self.level * self.effectPower + self.scale * self.mainStat) / self.duration
                }
            end
        end
    else 
        -- cooldown sound 
    end
end