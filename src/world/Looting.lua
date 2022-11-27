Looting = Class{__includes = BaseState}

function Looting:init(loot)
    self.loot = loot
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
    love.graphics.draw(gTextures['looting'], math.floor(self.loot.player.x - VIRTUAL_WIDTH / 2), math.floor(self.loot.player.y - VIRTUAL_HEIGHT / 2))

    for i = 1, #self.loot.content do
        self.loot.content[i]:render(math.floor(self.loot.player.x - VIRTUAL_WIDTH / 2), math.floor(self.loot.player.y - VIRTUAL_HEIGHT / 2))
    end

    self.loot.player:renderItems() 
end

function Looting:itemTransfer(k, item)
    if #self.loot.player.stash < STASH_LIMIT then
        self.loot.player:addToStash(item)
        table.remove(self.loot.content, k)
    else 
        --error sound
    end
end