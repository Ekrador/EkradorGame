Vendor = Class{}

function Vendor:init(def)
    self.player = def.player
    self.mapX = def.mapX
    self.mapY = def.mapY
    self.width = def.width 
    self.height = def.height 
    self.salesTable = {}
    self.nearPlayer = false
    self.x = (self.mapX-1)*0.5*GROUND_WIDTH + (self.mapY-1)*-1*GROUND_WIDTH*0.5

    self.y = (self.mapX-1)*0.5*GROUND_HEIGHT+ (self.mapY-1)*0.5*GROUND_HEIGHT - self.height + GROUND_HEIGHT
end

function Vendor:update(dt)
    if self:checkForPlayer() then
        self.nearPlayer = true
    else 
        self.nearPlayer = false
    end
end

function Vendor:updateAssortment()
    self.salesTable = {}
    local amountItems = math.random(4, 10)
    for i = 1, amountItems do
        local item = self:generateItem()
        table.insert(self.salesTable, item)
    end
end

function Vendor:onInteract()
    gStateStack:push(Trade(self, self.player))
end

function Vendor:render()
    love.graphics.draw(gTextures['vendor'], math.floor(self.x), math.floor(self.y))
    if self.nearPlayer then
        love.graphics.print('Press F to trade', gFonts['small'], self.x, self.y)
    end
end

function Vendor:generateItem()
    local itemTypes = {'head', 'chest', 'legs', 'boots', 'weapon', 'shield', 'neck', 'ring', 'gloves'}
    local itemType = itemTypes[math.random(#itemTypes)]
    local id = #self.salesTable
    local x = TRADE_FIRST_ITEM_X + id  % STASH_ITEMS_PER_ROW * ITEMS_INDENT
    local y = TRADE_FIRST_ITEM_Y + math.floor(id  % STASH_LIMIT / STASH_ITEMS_PER_ROW) * ITEMS_INDENT

    local item = Items{
        x = x,
        y = y,
        type = itemType,
        quality = 0,
        stats_multiplier = 0,
        armor = 0,
        damage = 0,
        block_chance = 0,
        block_damage = 0,    
    }
    item.price = math.random(30, 80)
    return item
end

function Vendor:checkForPlayer()
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