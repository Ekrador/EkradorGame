Potions = Class{}

function Potions:init(def)
    self.type = def.type
    self.amount = def.amount
    self.player = def.player
    self.drinked = false
    self.x = def.x
    self.y = def.y
    self.renderTooltips = false
    self.price = 30
end

function Potions:use()
    if self.type == 'Health' then
        if self.player.currentHealth < self.player.maxHealth and self.player.healPotionTimer == HEAL_POTION_COOLDOWN then
            self.player:heal(self.player.maxHealth * self.amount)
            self.drinked = true
            self.player.healPotionTimer = 0
            self:drink()  
        else
            wrongAction()
        end
    else 
        if self.player.energyBar == self.type and self.player.currentEnergy < self.player.maxEnergy and self.player.energyPotionTimer == ENERGY_POTION_COOLDOWN then
            self.player.currentEnergy = math.min((self.player.currentEnergy + self.player.maxEnergy * self.amount), self.player.maxEnergy)
            self.drinked = true
            self.player.energyPotionTimer = 0
            self:drink() 
        elseif self.player.energyBar ~= self.type then
            gSounds['wrong_potion']:stop()
            gSounds['wrong_potion']:play() 
        else
            wrongAction()
        end
    end
end

function Potions:render(x, y)
    local rx = mouseInScreenX + (x + VIRTUAL_WIDTH / 2)
    local ry = mouseInScreenY + (y + VIRTUAL_HEIGHT / 2)
    love.graphics.draw(gTextures[self.type..'_potion'], x + self.x, y + self.y)

    if rx >= x + self.x  and rx <= x + self.x + 15 and
    ry >= y + self.y  and ry <= y + self.y + 15 then
        self.renderTooltips = true
    else
        self.renderTooltips = false
    end
end

function Potions:renderGrabbed(x, y)
    love.graphics.draw(gTextures[self.type..'_potion'], x, y)
end

function Potions:renderTooltip(x, y)
    if self.renderTooltips then
        local tx = math.floor(mouseInScreenX + (x + VIRTUAL_WIDTH / 2)) + 3
        local ty = math.floor(mouseInScreenY + (y + VIRTUAL_HEIGHT / 2))
        local tooltipText = tostring(self.type)
        tooltipText = tooltipText .. '\n'.. "Restore " ..self.amount * 100 .. '%' .. string.lower(tostring(self.type)).. '\n' 
        tooltipText = tooltipText .. 'Price: ' .. self.price ..'\n'
        local textWidth  = gFonts['small']:getWidth(tooltipText)
	    local textHeight = gFonts['small']:getHeight()
        love.graphics.setColor(0, 0, 0, 0.9)
        love.graphics.rectangle('fill',tx , ty, textWidth, textHeight * 3, 3)
        love.graphics.setColor(0.2, 1, 0.2, 1)
        love.graphics.print(tooltipText, gFonts['small'], tx, ty)
        love.graphics.setColor(255, 255, 255, 1)
    end
end

function Potions:drink()
    gSounds['drink']:stop()
    gSounds['drink']:play() 
end