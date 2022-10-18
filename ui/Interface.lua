Interface = Class{}

function Interface:init(def)
    self.player = def.player
    self.class = def.class
    self.timer = 0
    self.inventory = Inventory(self.player, self.player.energyBar)
    self.holdTimer = 0
    self.grabbedSkill = 0
end

function Interface:update(dt)
    self.inventory:update(dt) 
    self:holdMouse(dt)
    self:dragSpells(dt)
end

function Interface:render(x, y)
    love.graphics.draw(gTextures['panel'],x, y)
    self:renderResources(x, y)
    self.inventory:render(x, y)
    for i = 1, 4 do
        if self.player.spellPanel[i] > 0 then
            love.graphics.draw(gTextures[tostring(self.player.class)..'_spells'],
                gFrames[tostring(self.player.class)..'_spells'][self.player.spells[self.player.spellPanel[i]].id], x + 93 + (i-1) * 20, y + 198)
        end
    end
    if self.grabbedSkill > 0 then
        love.graphics.draw(gTextures[tostring(self.player.class)..'_spells'],
        gFrames[tostring(self.player.class)..'_spells'][self.player.spells[self.grabbedSkill].id], math.floor(x + mx), math.floor(y + my))
    end
    self:tips(x, y)

    -- love.graphics.print(tostring(self.grabbedSkill), gFonts['medium'], x, y + 20)
    -- love.graphics.print(tostring(self.timer), gFonts['medium'], x, y + 10)
    -- love.graphics.print(tostring(self.holdTimer), gFonts['medium'], x, y + 40)

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



function Interface:dragSpells(dt)
    for i = 1, 4 do
        if ((mx > 90 + (i-1) * 20) and (mx < 90 + i * 20)) and (my > 195 and my < 215) then
            if love.mouse.isDown(1) and self.holdTimer > 0.6 and self.grabbedSkill == 0 then
                self.grabbedSkill = self.player.spellPanel[i]
            end

            if love.mouse.wasReleased(1) and self.holdTimer < 0.3 then
                if  self.player.spellPanel[i] > 0 then
                    self.player:changeState('ability', {id = self.player.spellPanel[i]})
                end
            end
        end
    end
    if love.mouse.wasReleased(1) and self.grabbedSkill > 0 then
            for i = 1, 4 do
                if ((mx > 90 + (i-1) * 20) and (mx < 90 + i * 20)) and (my > 195 and my < 215) then
                    self.player.spellPanel[i] = self.grabbedSkill
                    for j = 1, 4 do
                        if not i == j and self.player.spellPanel[j] == self.grabbedSkill then
                            self.player.spellPanel[j] = 0
                        end
                    end
                end
            end
        self.grabbedSkill = 0      
    end
end

function Interface:holdMouse(dt)
    if love.mouse.isDown(1) then
        self.holdTimer = self.holdTimer + dt
    end
    if love.mouse.wasReleased(1) then        
        self.holdTimer = 0
    end
end
        