Inventory = Class{__includes = BaseState}

function Inventory:init(player)
    self.player = player
    self.energy = player.energyBar
    self.x = math.floor(self.player.x - VIRTUAL_WIDTH / 2)
    self.y = math.floor(self.player.y - VIRTUAL_HEIGHT / 2)
    self.grabbedItem = nil
    self.grabbedItemIndex = 0
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
    if self.grabbedItemIndex ~= nil then
        love.graphics.print(tostring(self.grabbedItemIndex), math.floor(self.x + mx), math.floor(self.y + my))
    end
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
        for i = 1, STASH_LIMIT do
            if self.player.stash[i][1] ~= nil then
                local itemX = self.player.stash[i][1].x
                local itemY = self.player.stash[i][1].y
                if (mx > itemX and mx < itemX + 15) and 
                (my > itemY and my < itemY + 15) and love.mouse.wasPressed(1) then
                    self.grabbedItem = self.player.stash[i][1]
                    self.grabbedItemIndex = i
                end
                if mx >= itemX  and mx <= itemX + 16 and
                my >= itemY  and my <= itemY + 16 and love.mouse.wasPressed(2) then
                    local item = self.player.stash[i][1]
                    self:equipItem(item) 
                    self.player:calculateStats()
                    break   
                end
            end
        end

    if love.mouse.wasReleased(1) then
        if self.grabbedItem ~= nil then
            if mx < 48 or mx > 336 or my < 15 or my > 170 then 
                self.player.stash[self.grabbedItemIndex][1] = nil
                self.player.stashCounter = self.player.stashCounter - 1
            else
                for i = 1, 7 do
                    local y = STASH_FIRST_ITEM_Y + math.floor((i - 1) % STASH_ITEMS_PER_ROW ) * ITEMS_INDENT
                    for j = 1, 8 do
                        local x = STASH_FIRST_ITEM_X + (j - 1) % STASH_ITEMS_PER_ROW * ITEMS_INDENT
                        if (mx > x and mx < x + 16) and (my > y and my < y + 16) then 
                            for k = 1, STASH_LIMIT do
                                if self.player.stash[k][1] ~= nil then
                                    if self.player.stash[k][1].x == x and self.player.stash[k][1].y == y then
                                        local tempX = self.grabbedItem.x
                                        local tempY = self.grabbedItem.y
                                        local temp = self.player.stash[k][1]
                                        self.player.stash[k][1] = self.grabbedItem
                                        self.player.stash[k][1].x = x
                                        self.player.stash[k][1].y = y
                                        self.player.stash[self.grabbedItemIndex][1] = temp
                                        self.player.stash[self.grabbedItemIndex][1].x = tempX
                                        self.player.stash[self.grabbedItemIndex][1].y = tempY
                                        goto endFor
                                    end
                                end
                            end
                            self.player.stash[(i-1)*8 + j][1] = self.grabbedItem
                            self.player.stash[(i-1)*8 + j][1].x = x
                            self.player.stash[(i-1)*8 + j][1].y = y
                            self.player.stash[self.grabbedItemIndex][1] = nil
                            goto endFor                                                   
                        end
                    end
                end
            end             
        end
        ::endFor::
        self.grabbedItem = nil
    end

    if self.player.bonusPoints > 0 then
        if love.mouse.wasPressed(1) and (mx > 132 and mx < 143) and (my > 120 and my < 131) then
            self.player.totalStrength = self.player.totalStrength + 1
            self.player.bonusPoints = math.max(0, self.player.bonusPoints - 1)
        elseif love.mouse.wasPressed(1) and (mx > 132 and mx < 143) and (my > 132 and my < 143) then
            self.player.totalAgility = self.player.totalAgility + 1
            self.player.bonusPoints = math.max(0, self.player.bonusPoints - 1)
        elseif love.mouse.wasPressed(1) and (mx > 132 and mx < 143) and (my > 143 and my < 154) then
            self.player.totalIntelligence = self.player.totalIntelligence + 1
            self.player.bonusPoints = math.max(0, self.player.bonusPoints - 1)
        end
    end

    if love.keyboard.wasPressed('escape') or love.keyboard.wasPressed('c') then
        gStateStack:pop()
    end

    
end

function Inventory:equipItem(item)
    local slot = item.type
    local index 
        for k,v in pairs(self.player.stash) do
            if item == v[1] then
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
        self.player.stash[index][1] = wearedItem
        self.player.equipment[slot].weared = tempItem
    else
        self.player.equipment[slot].weared = item
        item.x = self.player.equipment[slot].coords.x
        item.y = self.player.equipment[slot].coords.y
        self.player.stash[index][1] = nil
        self.player.stashCounter = self.player.stashCounter - 1
    end
end


function Inventory:renderItems()
    for k,v in pairs(self.player.stash) do
        if v[1] ~= nil then
            v[1]:render(self.x, self.y)
        end
    end
    for k,v in pairs(self.player.stash) do
        if v[1] ~= nil then
            v[1]:renderTooltip(self.x, self.y)
        end
    end
    for k,v in pairs(self.player.equipment) do
        if v.weared ~= nil then
            v.weared:render(self.x, self.y)
        end
    end
    for k,v in pairs(self.player.equipment) do
        if v.weared ~= nil then
            v.weared:renderTooltip(self.x, self.y)
        end
    end
end