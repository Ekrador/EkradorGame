Looting = Class{__includes = BaseState}

function Looting:init(loot, player)
    self.loot = loot
    self.player = player
    self.x = math.floor(self.player.x - VIRTUAL_WIDTH / 2)
    self.y = math.floor(self.player.y - VIRTUAL_HEIGHT / 2)
end


-- function Looting:enter(loot)
--     self.loot = loot
-- end

function Looting:update(dt)
    --interaction with items
    self.loot:update(dt)
    self.loot.player:update(dt)

    for k, v in pairs(self.loot.content) do
        if (mx > v.x and mx < v.x + 15) and (my > v.y and my < v.y + 15) and love.mouse.wasPressed(2) then
            self:itemTransfer(k, v)
        end
    end 

    if ((mx > 55 and mx < 81) and (my > 99 and my < 110) and love.mouse.wasPressed(1)) then
        for k, v in pairs(self.loot.content) do
            self:itemTransfer(k, v)
        end
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
    for i = 1, #self.loot.content do
        self.loot.content[i]:renderTooltip(self.x, self.y)
    end
    love.graphics.print(string.format('%4s', tostring(self.player.gold)), gFonts['small'], self.x + 300, self.y + 160)
    love.graphics.print('Take all',gFonts['small'], self.x + 54, self.y + 103)
    love.graphics.print('Close',gFonts['small'], self.x + 89, self.y + 103)
    self:renderStashItems()
end

function Looting:itemTransfer(k, item)
    if self.player.stashCounter < STASH_LIMIT then
        self.loot.player:addToStash(item)
        table.remove(self.loot.content, k)
        self.player.stashCounter = self.player.stashCounter + 1
    else 
        --error sound
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