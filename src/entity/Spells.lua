Spells = = Class{}

function Spells:init(def)
    self.damage = def.damage
    self.range = def.range
    self.cost = def.cost
    self.energy = def.energy
    self.duration = def.duration
    self.effectToTarget = def.effectToTarget
    self.effectToSelf = def.effectToSelf
    self.aoe = def.aoe
    self.power = def.power
end

function Spells:use(target)
    if aoe then

    else
        if self.effectToTarget then
            target:getDebuff{
                status = self.effectToTarget,
                duration = self.duration,
                power = self.power
            }
        end
