Trade = Class{__includes = BaseState}

function Trade:init(vendor, player)
    self.vendor = vendor
    self.player = player
    self.x = math.floor(self.player.x - VIRTUAL_WIDTH / 2)
    self.y = math.floor(self.player.y - VIRTUAL_HEIGHT / 2)
end
function Trade:update(dt)
    self.player:update(dt)

    for k, v in pairs(self.vendor.salesTable) do
        if (mx > v.x and mx < v.x + 15) and (my > v.y and my < v.y + 15) and love.mouse.wasPressed(2) then
            self:buy(k, v)
        end
    end 
    
    if ((mx > 141 and mx < 165) and (my > 141 and my < 152) and love.mouse.wasPressed(1))
    or love.keyboard.wasPressed('escape') then
        gStateStack:pop()
    end
end
function Trade:buy(k, item)
    if self.player.stashCounter >= STASH_LIMIT then
        gSounds['need_space']:stop()
        gSounds['need_space']:play()
    elseif self.player.gold < item.price then
        gSounds['need_gold']:stop()
        gSounds['need_gold']:play()
    else 
        local newItem = self:identifyItem(item)
        self.player:addToStash(newItem)
        self.player.gold = self.player.gold - item.price
        table.remove(self.vendor.salesTable, k)
        self.player.stashCounter = self.player.stashCounter + 1
    end
end

function Trade:render()
    love.graphics.draw(gTextures['trade'], self.x,self.y)
    for i = 1, #self.vendor.salesTable do
        self.vendor.salesTable[i]:render(self.x, self.y)
    end
    for i = 1, #self.vendor.salesTable do
        self.vendor.salesTable[i]:renderTooltip(self.x, self.y)
    end
    love.graphics.print(string.format('%4s', tostring(self.player.gold)), gFonts['small'], self.x + 300, self.y + 160)
    love.graphics.print('Close',gFonts['small'], self.x + 145, self.y + 144)
    self:renderStashItems()
end

function Trade:identifyItem(item)
    local type = item.type
    local newItem = Items{
        x = x,
        y = y,
        type = type,
        quality = math.random(2, 4),
        stats_multiplier = ITEMS_DEFS[type].stats_multiplier,
        block_chance = ITEMS_DEFS[type].block_chance,
        block_damage = ITEMS_DEFS[type].block_damage,
        damage = ITEMS_DEFS[type].damage,
        armor = ITEMS_DEFS[type].armor,
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