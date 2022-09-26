Interface = Class{}

function Interface:init(def)
    self.player = def.player
    self.class = def.class
    self.x = def.x
    self.y = def.y
    
    self.inventory = Inventory(self.player, self.player.energyBar)
    
end

function Interface:render(x, y)
    love.graphics.draw(gTextures['panel'],x, y)
    self:renderResources(x, y)
    self:tips(x, y)
    self.inventory:render(x, y)
    -- self.talentTree:render(x, y)
end

function Interface:renderResources(x, y)
    local healthPercent = 38 - math.floor(self.player.currentHealth / self.player.maxHealth * 38)
    local energyBar = 38 - math.floor(self.player.currentEnergy / self.player.maxEnergy * 38)
    for i = 1, 38 do
        if i <= energyBar then
            love.graphics.setColor(255, 255, 255, 0)
        else
            love.graphics.setColor(255, 255, 255, 1)
        end
        love.graphics.draw(gTextures[self.player.energyBar], gFrames[self.player.energyBar][i], x + 296, y + 176 + i)

        if i <= healthPercent then
            love.graphics.setColor(255, 255, 255, 0)
        else
            love.graphics.setColor(255, 255, 255, 1)
        end
        love.graphics.draw(gTextures['health'], gFrames['health'][i], x + 50, y + 176 + i)
    end
    love.graphics.setColor(255, 255, 255, 1)
end

function Interface:tips(x, y)
    if (mx > 50 and mx < 89) and (my > 176 and my < 214) then
        love.graphics.print('HP: '..tostring(self.player.currentHealth),gFonts['small'], math.floor(x + mx), math.floor(y + my - 10))
    elseif (mx > 296 and mx < 335) and (my > 176 and my < 214) then
        love.graphics.print(tostring(self.player.energyBar)..': '..tostring(self.player.currentEnergy),gFonts['small'], math.floor(x + mx), math.floor(y + my - 10))
    end
end