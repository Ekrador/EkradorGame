Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
    self.maxEnergy = 100
    self.currentEnergy = def.currentEnergy
    self.regenEnergy = def.regenEnergy
    self.regenRate = def.regenRate
    self.regenTimer = 0
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
    self.damage = self.strength
    self.cooldownReduction = 1
    self.level = 1
    self.xp = 0
    self.xpToLevel = self.level * 100
    self.bonusPoints = 5
    self.talentPoints = 1
    self.gold = 0
    self.step = {}
    if self.class == 'warrior' then
        self.energyBar = 'Rage'
    elseif self.class == 'ranger' then
        self.energyBar = 'Energy'
    elseif self.class == 'mage' then
        self.energyBar = 'Mana'
    end
    for k, v in pairs(ENTITY_SPELLS['player'][self.class]) do
        spell = Spells(v, self)
        table.insert(self.spells, spell)
    end
    self.GUI = Interface{
        class = self.class,
        player = self
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

    self.stash = {}
end

function Player:update(dt)
    self.stateMachine:update(dt)
    for k, v in pairs(self.spells) do
        v:update(dt)
    end
    self.GUI:update(dt)
    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end

    self:calculateStats()

    self:regenerateEnergy(dt)

    self:useSpell()

    for i = 1, 5 do
        if love.keyboard.wasPressed(self.itemsKeys[i]) then
            if self.belt[i] > 0 then
                self.belt[i]:use()
            end
        end
    end

    

        -- FOR DEBUG
        if love.keyboard.wasPressed('space') then
            self:heal(15)
        end
        if love.keyboard.wasPressed('c') then
            gStateStack:push(Inventory(self))
        end
        if love.keyboard.wasPressed('p') then
            gStateStack:push(TalentTree(self))
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

function Player:getXp(xp)
    self.xp = self.xp + xp
    if self.xpToLevel <= self.xp then
        self.bonusPoints = self.bonusPoints + BONUS_POINTS_LVLUP
        self.talentPoints = self.talentPoints + TALENT_POINTS_LVLUP
        self.xp = self.xp - self.xpToLevel
        self.xpToLevel = self.level * 100
        self:getXp(0)
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
        self.currentEnergy = math.max(0, math.min(self.maxEnergy, self.currentEnergy + self.regenEnergy))
    end
end


function Player:move(path, speed)
    for i = 1, #path do
        table.insert(self.actionsQueue, path[i])
    end

    self:steps(1, speed)
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
    self.step = Timer.tween(1 / speed,{
        [self] = { x = newX, y = newY }
    })  
    self.step:register():finish(function()  
        self:steps(i + 1, speed)
    end)
end

function Player:calculateStats()
    local strength = 0
    local agility = 0
    local intelligence = 0

    for k, v in pairs(self.equipment) do
        strength = strength + (v.strength and v.strength or 0)
        agility = agility + (v.agility and v.agility or 0)
        intelligence = intelligence + (v.intelligence and v.intelligence or 0)
    end

    self.totalStrength = strength + self.strength
    self.totalAgility = agility + self.agility
    self.totalIntelligence = intelligence + self.intelligence
end



function Player:addToStash(item)
    local id 
    for i = 1, #self.stash do
        if self.stash[i+1] == nil then
            id = i + 1
            break
        end
    end
    if #self.stash == 0 then
        id = 1
    end
    item.x = STASH_FIRST_ITEM_X + (id - 1) % STASH_ITEMS_PER_ROW * ITEMS_INDENT
    item.y = STASH_FIRST_ITEM_Y + math.floor((id - 1) % STASH_LIMIT / STASH_ITEMS_PER_ROW) * ITEMS_INDENT
    table.insert(self.stash, id, item)
end



function Player:unequipItem(item)

end