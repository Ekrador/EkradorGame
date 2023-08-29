Loot = Class{}

function Loot:init(mapX, mapY, player)
    self.player = player
    self.mapX = mapX
    self.mapY = mapY
    self.x = (self.mapX-1) * 0.5 * GROUND_WIDTH + (self.mapY-1) * -1 * GROUND_WIDTH * 0.5
    self.y = (self.mapX-1) * 0.5 * GROUND_HEIGHT + (self.mapY-1) * 0.5 * GROUND_HEIGHT 
    self.checked = false
    self.content = {}
    self:spawn()
    self.nearPlayer = false
    self.goldAmount = math.random(0, 10)
end

function Loot:spawn()
    self.content = {}
    local amountItems = math.random(1, 3)
    for i = 1, amountItems do
        local item = self:generateItem()
        table.insert(self.content, item)
    end
end

function Loot:use()
    gStateStack:push(Looting(self, self.player))
end

function Loot:update(dt)
    if (#self.content > 0 or self.goldAmount > 0) and self:checkForPlayer() then
        self.nearPlayer = true
    else 
        self.nearPlayer = false
    end
end

function Loot:generateItem()
    local itemTypes = {'head', 'chest', 'legs', 'boots', 'weapon', 'shield', 'neck', 'ring', 'gloves'}
    local itemType = itemTypes[math.random(#itemTypes)]
    local id = #self.content
    local x = LOOT_FIRST_ITEM_X + id % LOOT_ITEMS_PER_ROW * ITEMS_INDENT
    local y = LOOT_FIRST_ITEM_Y + math.floor(id % LOOT_LIMIT / LOOT_ITEMS_PER_ROW) * ITEMS_INDENT

    local item = Items{
        x = x,
        y = y,
        type = itemType,
        quality = defineItemQuality(),
        stats_multiplier = ITEMS_DEFS[itemType].stats_multiplier,
        block_chance = ITEMS_DEFS[itemType].block_chance,
        block_damage = ITEMS_DEFS[itemType].block_damage,
        damage = ITEMS_DEFS[itemType].damage,
        armor = ITEMS_DEFS[itemType].armor,
    }

    return item
end

function Loot:render(x, y)
    if (#self.content > 0 or self.goldAmount > 0) then
        love.graphics.draw(gTextures['loot'], self.x, self.y)
    end

    if (#self.content > 0 or self.goldAmount > 0) and self.nearPlayer then
        love.graphics.print('Press F to loot', gFonts['small'], self.x, self.y)
    end
end

function Loot:checkForPlayer()
    if self.mapX == self.player.mapX and self.mapY == self.player.mapY then
        return true
    else
        for i = 1, #MDx do
            if self.player.mapX == self.mapX + MDx[i] and self.player.mapY == self.mapY + MDy[i] then
                return true
            end
        end
    end
    return false
end 