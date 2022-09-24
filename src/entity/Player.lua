Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
    self.maxEnergy = 100
    self.currentEnergy = def.currentEnergy
    self.regenEnergy = def.regenEnergy
    self.regenRate = def.regenRate
    self.regenTimer = 0
    self.class = def.class
    self.spells = {}
    self.strength = def.strength
    self.agility = def.agility
    self.intelligence = def.intelligence
    self.damage = self.strenght
    self.bonusPoints = 5
    self.gold = 0
    self.spellBook = {}
    for k, v in pairs(ENTITY_SPELLS['player'][self.class]) do
        spell = Spells{ENTITY_SPELLS['player'][self.class].v, self}
        table.insert(self.spells, spell)
    end
    self.GUI = Interface{
        class = self.class,
        player = self
        }
end

function Player:update(dt)
    self.stateMachine:update(dt)

    self.GUI.inventory:update(dt)
    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end

        self.regenTimer = self.regenTimer + dt

    if self.regenTimer > self.regenRate then
        self.regenTimer = 0
        self.currentEnergy = math.max(0, math.min(self.maxEnergy, self.currentEnergy + self.regenEnergy))
    end

    

        -- FOR DEBUG
        if love.keyboard.wasPressed('space') then
            self:heal(15)
        end
        if love.keyboard.wasPressed('w') then
            self:getEnergy(15)
        end
        if love.keyboard.wasPressed('q') then
            self:spentEnergy(20)
        end
        if love.keyboard.wasPressed('c') then
            self.GUI.inventory:togle()
        end
        if love.keyboard.wasPressed('p') then
            self.GUI.talentTree:togle()
        end

end

function Player:getEnergy(amount)
    self.currentEnergy = math.min(self.maxEnergy, self.currentEnergy + amount)
end

function Player:spentEnergy(amount)
    self.currentEnergy = math.max(0, self.currentEnergy - amount)
end

function Player:render(x, y)
    self.stateMachine:render()
    self.GUI:render(x, y)
end