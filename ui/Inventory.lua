Inventory = Class{__includes = BaseState}

function Inventory:init(player, energy)
    self.player = player
    self.energy = energy
    self.x = math.floor(self.player.x - VIRTUAL_WIDTH / 2)
    self.y = math.floor(self.player.y - VIRTUAL_HEIGHT / 2)
end


function Inventory:render()
    local x = self.x
    local y = self.y



    local frame = 2
    love.graphics.draw(gTextures['inventory'],x, y)
    love.graphics.print('Available points: '..tostring(self.player.bonusPoints),gFonts['small'], x + 76, y + 110)
    love.graphics.print('Strength:    '..tostring(self.player.totalStrength),gFonts['small'], x + 66, y + 122)
    love.graphics.print('Agility:       '..tostring(self.player.totalAgility),gFonts['small'], x + 66, y + 134)
    love.graphics.print('Intelligence: '..tostring(self.player.totalIntelligence),gFonts['small'], x + 66, y + 145)
    love.graphics.print(tostring(self.energy)..' regeneration: '..tostring(self.player.regenEnergy),gFonts['small'], x + 66, y + 156)
    love.graphics.print(string.format('%4s', tostring(self.player.gold)), gFonts['small'], x + 300, y + 160)
    
    if self.player.bonusPoints > 0 then
        frame = 1
    end
    love.graphics.draw(gTextures['plus'], gFrames['plus'][frame],x + 132, y + 120)
    love.graphics.draw(gTextures['plus'], gFrames['plus'][frame],x + 132, y + 132)
    love.graphics.draw(gTextures['plus'], gFrames['plus'][frame],x + 132, y + 144)
    self:renderItems()
    self:tips(self.x, self.y)
end


function Inventory:tips(x, y)
    if (mx > 64 and mx < 144) and (my > 121 and my < 132) then
        love.graphics.print('Strength: your melee attack deal more physical\n damage',gFonts['small'], x + 88, y + 175)
    elseif (mx > 64 and mx < 144) and (my > 133 and my < 143) then
        love.graphics.print('Agility: your ranged attack deals more physical\n damage and also increases your attack speed.',gFonts['small'], x + 88, y + 175)
    elseif (mx > 64 and mx < 144) and (my > 144 and my < 155) then
        love.graphics.print('Intelligence: affects the maximum amount of mana\n and its regeneration',gFonts['small'], x + 88, y + 175)
    end
end

function Inventory:update(dt)
    if love.mouse.wasPressed(2) then
        for i = 1, #self.player.stash do
            if self.player.stash[i] ~= nil then
                local itemX = self.player.stash[i].x
                local itemY = self.player.stash[i].y
                if mx >= itemX  and mx <= itemX + 16 and
                my >= itemY  and my <= itemY + 16 then
                    local item = self.player.stash[i]
                    self:equipItem(item) 
                    break   
                end
            end
        end
    end

    self.player:calculateStats()
        if self.player.bonusPoints > 0 then
            if love.mouse.wasPressed(1) and (mx > 132 and mx < 143) and (my > 120 and my < 131) then
                self.player.strength = self.player.strength + 1
                self.player.bonusPoints = math.max(0, self.player.bonusPoints - 1)
            elseif love.mouse.wasPressed(1) and (mx > 132 and mx < 143) and (my > 132 and my < 143) then
                self.player.agility = self.player.agility + 1
                self.player.bonusPoints = math.max(0, self.player.bonusPoints - 1)
            elseif love.mouse.wasPressed(1) and (mx > 132 and mx < 143) and (my > 143 and my < 154) then
                self.player.intelligence = self.player.intelligence + 1
                self.player.bonusPoints = math.max(0, self.player.bonusPoints - 1)
            end
        end

        if love.keyboard.wasPressed('escape') or love.keyboard.wasPressed('c') then
            gStateStack:pop()
        end
end

function Inventory:equipItem(item)
    --перенести в инвентарь, переделать отрисовку
    local slot = item.type
    local index 
        for k,v in pairs(self.player.stash) do
            if item == v then
                index = k
                break
            end
        end 
    if self.player.equipment[slot].weared ~= nil then  
        local wearedItem = self.player.equipment[slot].weared
        local tempX, tempY = wearedItem.x, wearedItem.y
        local tempItem = item
        wearedItem.x = item.x
        wearedItem.y = item.y      
        item.x = tempX
        item.y = tempY
        self.player.stash[index] = wearedItem
        self.player.equipment[slot].weared = tempItem
    else
        self.player.equipment[slot].weared = item
        item.x = self.player.equipment[slot].coords.x
        item.y = self.player.equipment[slot].coords.y
        self.player.stash[index] = nil
    end
end


function Inventory:renderItems()
    for k,v in pairs(self.player.stash) do
        if v ~= nil then
            v:render(self.x, self.y)
        end
    end
    for k,v in pairs(self.player.equipment) do
        if v.weared ~= nil then
            v.weared:render(self.x, self.y)
        end
    end
end