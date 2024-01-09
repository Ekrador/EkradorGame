Trade = Class{__includes = BaseState}

function Trade:init(vendor, player)
    self.vendor = vendor
    self.player = player
    self.x = math.floor(self.player.x - VIRTUAL_WIDTH / 2)
    self.y = math.floor(self.player.y - VIRTUAL_HEIGHT / 2)
    self.tradeTabs = {'items', 'potions'}
    self.currentTradeTab = 'items'
    self.potions = {}
    for i = 1, #POTION_TYPES do
        table.insert(self.potions, Potions {type = POTION_TYPES[i],
         amount = POTIONS_DEFS[POTION_TYPES[i]].amount,
         player = self.player,
         x = TRADE_FIRST_ITEM_X + (i - 1) % STASH_ITEMS_PER_ROW * ITEMS_INDENT,
         y = TRADE_FIRST_ITEM_Y + math.floor(i % STASH_LIMIT / STASH_ITEMS_PER_ROW) * ITEMS_INDENT,
        })
    end
end
function Trade:update(dt)
    if mx > 31 and mx < 56 and my > 18 and my < 34 and love.mouse.wasPressed(1) then
        self.currentTradeTab = 'items'
    elseif mx > 63 and mx < 88 and my > 18 and my < 34 and love.mouse.wasPressed(1) then
        self.currentTradeTab = 'potions'
    end

    if self.currentTradeTab == 'items' then
        for k, v in pairs(self.vendor.salesTable) do
            if (mx > v.x and mx < v.x + 15) and (my > v.y and my < v.y + 15) and love.mouse.wasPressed(2) then
                self:buyItem(k, v)
            end
        end 
    elseif self.currentTradeTab == 'potions' then
        for k, v in pairs(self.potions) do
            if (mx > v.x and mx < v.x + 15) and (my > v.y and my < v.y + 15) and love.mouse.wasPressed(2) then
                self:buyPotinon(v)
            end
        end
    end

    for i = 1, STASH_LIMIT do
        if self.player.stash[i][1] ~= nil then
            local itemX = self.player.stash[i][1].x
            local itemY = self.player.stash[i][1].y
            if mx >= itemX  and mx <= itemX + 16 and
            my >= itemY  and my <= itemY + 16 and love.mouse.wasPressed(2) then
                local item = self.player.stash[i][1]
                self:sell(i, item)                
                break   
            end
        end
    end
    
    if ((mx > 108 and mx < 138) and (my > 141 and my < 152) and love.mouse.wasPressed(1)) then
        for i = 1, STASH_LIMIT do
            if self.player.stash[i][1] ~= nil then
                local item = self.player.stash[i][1]
                self:sell(i, item)                
            end
        end
    end
    if ((mx > 141 and mx < 165) and (my > 141 and my < 152) and love.mouse.wasPressed(1))
    or love.keyboard.wasPressed('escape') then
        gStateStack:pop()
    end
end
function Trade:buyItem(k, item)
    if self.player.stashCounter >= STASH_LIMIT then
        gSounds['need_space']:stop()
        gSounds['need_space']:play()
    elseif self.player.gold < item.price then
        gSounds['need_gold']:stop()
        gSounds['need_gold']:play()
    else 
        local newItem = self:identifyItem(item)
        self.player:addToStash(newItem)
        itemSwapSound()
        self.player.gold = self.player.gold - item.price
        table.remove(self.vendor.salesTable, k)
        self.player.stashCounter = self.player.stashCounter + 1
    end
end

function Trade:buyPotinon(potion)
    if self.player.stashCounter >= STASH_LIMIT then
        gSounds['need_space']:stop()
        gSounds['need_space']:play()
    elseif self.player.gold < potion.price then
        gSounds['need_gold']:stop()
        gSounds['need_gold']:play()
    else 
        self.player:addToStash(Potions {type = potion.type,
        amount = POTIONS_DEFS[potion.type].amount,
        player = self.player,
        price = 10
       })
        itemSwapSound()
        self.player.gold = self.player.gold - potion.price
        self.player.stashCounter = self.player.stashCounter + 1
    end
end

function Trade:sell(i, item)
    self.player.gold = self.player.gold + item.price
    coinSound()  
    self.player.stash[i][1] = nil
    self.player.stashCounter = self.player.stashCounter - 1
end

function Trade:render()
    love.graphics.draw(gTextures['trade'], self.x,self.y)
        love.graphics.setColor(0, 0, 0, 0.7)
        love.graphics.rectangle('fill',self.x + 30 , self.y + 18, 26, 9, 3)
        if self.currentTradeTab == 'items' then
            love.graphics.setColor(0.2, 1, 0.2, 1)
        else
            love.graphics.setColor(255, 255, 255, 0.7)
        end    
        love.graphics.print('Items', gFonts['small'], self.x + 32, self.y + 18)
        love.graphics.setColor(0, 0, 0, 0.7)
        love.graphics.rectangle('fill',self.x + 61 , self.y + 18, 33, 9, 3)
        if self.currentTradeTab == 'potions' then
            love.graphics.setColor(0.2, 1, 0.2, 1)
        else
            love.graphics.setColor(255, 255, 255, 0.7)
        end
        love.graphics.print('Potions', gFonts['small'], self.x + 63, self.y + 18)
        love.graphics.setColor(255, 255, 255, 1)
    if self.currentTradeTab == 'items' then
        for i = 1, #self.vendor.salesTable do
            self.vendor.salesTable[i]:render(self.x, self.y)
        end
        for i = 1, #self.vendor.salesTable do
            self.vendor.salesTable[i]:renderTooltip(self.x, self.y)
        end
    elseif self.currentTradeTab == 'potions' then
        for i = 1, #self.potions do
            self.potions[i]:render(self.x, self.y)
        end
        for i = 1, #self.potions do
            self.potions[i]:renderTooltip(self.x, self.y)
        end
    end
    love.graphics.print(string.format('%4s', tostring(self.player.gold)), gFonts['small'], self.x + 300, self.y + 160)
    love.graphics.print('Sell all',gFonts['small'], self.x + 111, self.y + 144)
    love.graphics.print('Close',gFonts['small'], self.x + 145, self.y + 144)
    self:renderStashItems()
end

function Trade:identifyItem(item)
    local type = item.type
    local item = ITEMS_DEFS[type]()
    local newItem = Items{
        x = x,
        y = y,
        type = type,
        quality = defineItemQuality(),
        stats_multiplier = item.stats_multiplier,
        block_chance = item.block_chance,
        block_damage = item.block_damage,
        damage = item.damage,
        armor = item.armor,
    }
    return newItem
end

function Trade:renderStashItems()
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
end