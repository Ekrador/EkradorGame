Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
    self.maxEnergy = 100
    self.currentEnergy = def.currentEnergy
    self.regenEnergy = def.regenEnergy
    self.regenRate = def.regenRate
    self.regenTimer = 0
    self.regenHp = def.regenHp
    self.actionsQueue = {}
    self.class = def.class
    self.spells = {}
    self.spellPanel = {0,0,0,0}
    self.spellKeys = {'q','w','e','r'}
    self.itemsKeys = {'1','2','3','4','5'}
    self.consumables = {}
    self.strength = def.strength
    self.agility = def.agility
    self.intelligence = def.intelligence
    self.totalStrength = def.strength
    self.totalAgility = def.agility
    self.totalIntelligence = def.intelligence
    self.damage = self.totalStrength
    self.cooldownReduction = 1
    self.level = def.level
    self.playerlevel = 1
    self.xp = 0
    self.xpToLevel = self.playerlevel * 100
    self.bonusPoints = 5
    self.talentPoints = 1
    self.healPotionTimer = 0
    self.energyPotionTimer = 0
    self.healPotionReady = false
    self.energyPotiReady = false
    self.gold = 100
    self.step = {}
    if self.class == 'warrior' then
        self.energyBar = 'Rage'
    elseif self.class == 'ranger' then
        self.energyBar = 'Energy'
    elseif self.class == 'mage' then
        self.energyBar = 'Mana'
    end
    self.GUI = Interface{
        class = self.class,
        player = self,
        }

    self.equipment = {
        chest = {
            weared = nil,
            coords = {x = 96, y = 44}
        },
        head = {
            weared = nil,
            coords = {x = 96, y = 26}
        },
        legs = {
            weared = nil,
            coords = {x = 96, y = 63}
        },
        gloves = {
            weared = nil,
            coords = {x = 74, y = 67}
        },
        boots = {
            weared = nil,
            coords = {x = 96, y = 84}
        },
        ring = {
            weared = nil,
            coords = {x = 119, y = 84}
        },
        neck = {
            weared = nil,
            coords = {x = 115, y = 34}
        },
        weapon = {
            weared = nil,
            coords = {x = 74, y = 48}
        },
        shield = {
            weared = nil,
            coords = {x = 119, y = 60}
        },
    }    

    self.belt = {}
    for i = 1, 5 do
        self.belt[i] = {}
    end

    self.stash = {}
    for i = 1, 56 do
        self.stash[i] = {}
    end
    self.stashCounter = 0
end

function Player:update(dt)
    self.stateMachine:update(dt)
    self:calculateStats()
    
    for k, v in pairs(self.spells) do
        v:update(dt)
    end
    
    self:potionsCooldownHandler(dt)
    self:healthChangedTimer(dt)
    self:checkBeltUsage()
    self.GUI:update(dt)
    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end


    self:regenerateEnergy(dt)

    self:useSpell()

    for i = 1, 5 do
        if love.keyboard.wasPressed(self.itemsKeys[i]) then
            if self.belt[i][1] ~= nil then
                self.belt[i][1]:use()
            end
        end
    end

    if love.keyboard.wasPressed('c') then
        gStateStack:push(Inventory(self))
    end
    if love.keyboard.wasPressed('v') then
        gStateStack:push(TalentTree(self))
    end
end

function Player:takedamage(amount)
    local shield = self.equipment.shield.weared
    if shield then
        if math.random(100) <= shield.block_chance then
            amount = math.max(amount - shield.block_damage, 1)
        end
    end
    Entity.takedamage(self, amount)
end

function Player:getEnergy(amount)
    self.currentEnergy = math.min(self.maxEnergy, self.currentEnergy + amount)
end

function Player:spentEnergy(amount)
    self.currentEnergy = math.max(0, self.currentEnergy - amount)
end

function Player:render()
    self.stateMachine:render()    
    self:healthChangedDisplay()         
end

function Player:getXp(xp)
    self.xp = self.xp + xp
    if self.xpToLevel <= self.xp then
        self:heal(20)
        self.playerlevel = self.playerlevel + 1
        self.bonusPoints = self.bonusPoints + BONUS_POINTS_LVLUP
        self.talentPoints = self.talentPoints + TALENT_POINTS_LVLUP
        self.xp = self.xp - self.xpToLevel
        self.xpToLevel = self.playerlevel * 100
        self:getXp(self.xp)
    end
end

function Player:useSpell()
    for i = 1, 4 do
        if love.keyboard.wasPressed(self.spellKeys[i]) then
            if self.spellPanel[i] <= 0 then
                return
            end
            self:changeState('ability', {id = self.spellPanel[i]})
        end
    end
end

function Player:regenerateEnergy(dt)
    self.regenTimer = self.regenTimer + dt

    if self.regenTimer > self.regenRate then
        self.regenTimer = 0
        self.currentHealth = math.min(self.maxHealth, self.currentHealth + self.regenHp)
        self.currentEnergy = math.max(0, math.min(self.maxEnergy, self.currentEnergy + self.regenEnergy))
    end
end


function Player:move(path, speed)
    for i = 1, #path do
        table.insert(self.actionsQueue, path[i])
    end
    if #self.step > 0 then
        self.step:finish(function()
            self:steps(1, speed)
        end)
    else
        self:steps(1, speed)
    end
    
end


function Player:steps(i, speed)
    if self.stop then
        self.stop = false
        self.getCommand = false
        return 
    end

    if not self.getCommand then
        return
    end
   
    if i > #self.actionsQueue then
        self.actionsQueue = {}
        self.getCommand = false
        self:changeState('idle')
        return
    end

    local path = self.actionsQueue
    self.mapX = path[i].x
    self.mapY = path[i].y
    local newX = (path[i].x-1)*0.5*self.width + (path[i].y-1)*-1*self.width*0.5
    local newY = (path[i].x-1)*0.5*GROUND_HEIGHT+ (path[i].y-1)*0.5*GROUND_HEIGHT - self.height + GROUND_HEIGHT
    self.direction = self.directions[path[i].direction]
    self:changeAnimation('walk-' .. tostring(self.direction))
    gSounds['step']:stop()
    gSounds['step']:play() 
    self.step = Timer.tween(1 / speed,{
        [self] = { x = newX, y = newY }
    }):finish(function()  
        self:steps(i + 1, speed)
    end)
end

function Player:calculateStats()
    local strength = 0
    local agility = 0
    local intelligence = 0
    local damage = 3
    local armor = 0
    for k, v in pairs(self.equipment) do
        if v.weared ~= nil then
            strength = strength + (v.weared.strength and v.weared.strength or 0)
            agility = agility + (v.weared.agility and v.weared.agility or 0)
            intelligence = intelligence + (v.weared.intelligence and v.weared.intelligence or 0)
            damage = damage + (v.weared.damage and v.weared.damage or 0)
            armor = armor + (v.weared.armor and v.weared.armor or 0)
        end
    end

    self.totalStrength = strength + self.strength
    self.totalAgility = agility + self.agility
    self.totalIntelligence = intelligence + self.intelligence
    self.maxHealth = 100 + strength * 6
    self.attackSpeed = 1 + agility * 0.01
    self.damage = math.random((self.totalStrength + damage) * 0.8, self.totalStrength + damage) + 9999
    self.armor = armor
end



function Player:addToStash(item)
    local id 
    for i = 1, STASH_LIMIT do
        if self.stash[i][1] == nil then
            id = i
            break
        end
    end
    item.x = STASH_FIRST_ITEM_X + (id - 1) % STASH_ITEMS_PER_ROW * ITEMS_INDENT
    item.y = STASH_FIRST_ITEM_Y + math.floor((id - 1) % STASH_LIMIT / STASH_ITEMS_PER_ROW) * ITEMS_INDENT
    self.stash[id][1] = item
end



function Player:potionsCooldownHandler(dt)
    self.healPotionTimer = math.min(self.healPotionTimer + dt, HEAL_POTION_COOLDOWN)
    self.energyPotionTimer = math.min(self.energyPotionTimer + dt, ENERGY_POTION_COOLDOWN)
    if self.healPotionTimer == HEAL_POTION_COOLDOWN then
        self.healPotionReady = true
    else
        self.healPotionReady = false
    end
    if self.energyPotionTimer == ENERGY_POTION_COOLDOWN then
        self.energyPotionReady = true
    else
        self.energyPotionReady = false
    end
end

function Player:checkBeltUsage()
    for i = 1, 5 do
        if self.belt[i][1] ~= nil then
            if self.belt[i][1].drinked then
                self.belt[i][1] = nil
            end
        end
    end
end

function Player:initplayerSpells()
    local spells = {}
    for k, v in pairs(ENTITY_SPELLS['player'][self.class]) do
        spell = Spells(v, self, self.level)
        table.insert(spells, spell)
    end
    for k, v in pairs(spells) do
        self.spells[v.id] = v
    end
end