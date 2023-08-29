Looting = Class{__includes = BaseState}

function Looting:init(loot, player)
    self.loot = loot
    self.player = player
    self.x = math.floor(self.player.x - VIRTUAL_WIDTH / 2)
    self.y = math.floor(self.player.y - VIRTUAL_HEIGHT / 2)
    self.goldX = LOOT_FIRST_ITEM_X + (#self.loot.content) % LOOT_ITEMS_PER_ROW * ITEMS_INDENT
    self.goldY = LOOT_FIRST_ITEM_Y + math.floor((#self.loot.content) % LOOT_LIMIT / LOOT_ITEMS_PER_ROW) * ITEMS_INDENT
end


-- function Looting:enter(loot)
--     self.loot = loot
-- end

function Looting:update(dt)
    --interaction with items
    self.player:update(dt)

    for k, v in pairs(self.loot.content) do
        if (mx > v.x and mx < v.x + 15) and (my > v.y and my < v.y + 15) and love.mouse.wasPressed(2) then
            self:itemTransfer(k, v)
        end
    end 

    if (mx > self.goldX and mx < self.goldX + 15) and (my > self.goldY and my < self.goldY + 15) and love.mouse.wasPressed(2) then
        self.player.gold = self.player.gold + self.loot.goldAmount
        coinSound()
        self.loot.goldAmount = 0
    end

    if ((mx > 55 and mx < 81) and (my > 99 and my < 110) and love.mouse.wasPressed(1)) then
        for k, v in pairs(self.loot.content) do
            self:itemTransfer(k, v)
        end
        self.player.gold = self.player.gold + self.loot.goldAmount
        if self.loot.goldAmount > 0 then
            coinSound()
        end
        self.loot.goldAmount = 0
    end
    
    if #self.loot.content < 1 or ((mx > 85 and mx < 110) and (my > 99 and my < 110) and love.mouse.wasPressed(1))
    or love.keyboard.wasPressed('escape') then
        gStateStack:pop()
    end
end


function Looting:render()
    love.graphics.draw(gTextures['looting'], self.x,self.y)
    for i = 1, #self.loot.content do
        self.loot.content[i]:render(self.x, self.y)
    end
    self:renderGold()
    
    for i = 1, #self.loot.content do
        self.loot.content[i]:renderTooltip(self.x, self.y)
    end

    love.graphics.print(string.format('%4s', tostring(self.player.gold)), gFonts['small'], self.x + 300, self.y + 160)
    love.graphics.print('Take all',gFonts['small'], self.x + 54, self.y + 103)
    love.graphics.print('Close',gFonts['small'], self.x + 89, self.y + 103)
    self:renderStashItems()
end

function Looting:itemTransfer(k, item)
    if self.player.stashCounter >= STASH_LIMIT then
        gSounds['need_space']:stop()
        gSounds['need_space']:play()   
    else 
        self.loot.player:addToStash(item)
        itemSwapSound()  
        table.remove(self.loot.content, k)
        self.player.stashCounter = self.player.stashCounter + 1
    end
end

function Looting:renderStashItems()
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

function Looting:renderGold()
    if self.loot.goldAmount > 0 then
        love.graphics.draw(gTextures['gold'], self.x + self.goldX, self.y + self.goldY)
        local tx = math.floor(mouseInScreenX + (self.x + VIRTUAL_WIDTH / 2)) + 3
        local ty = math.floor(mouseInScreenY + (self.y + VIRTUAL_HEIGHT / 2))
        if tx - 3 >= self.x + self.goldX  and tx - 3 <= self.x + self.goldX + 15 and
        ty >= self.y + self.goldY  and ty <= self.y + self.goldY + 15 then        
            local tooltipText = tostring(self.loot.goldAmount .. ' gold')
            local textWidth  = gFonts['small']:getWidth(tooltipText)
            local textHeight = gFonts['small']:getHeight()
            love.graphics.setColor(0, 0, 0, 0.8)
            love.graphics.rectangle('fill',tx , ty, textWidth, textHeight, 3)
            love.graphics.setColor(0.2, 1, 0.2, 1)
            love.graphics.print(tooltipText, gFonts['small'], tx, ty)
            love.graphics.setColor(255, 255, 255, 1)
        end
    end
end

function Looting:coinSound()
    gSounds['coin']:stop()
    gSounds['coin']:play() 
end

function Looting:itemSwapSound()
    gSounds['item_swap']:stop()
    gSounds['item_swap']:play() 
end