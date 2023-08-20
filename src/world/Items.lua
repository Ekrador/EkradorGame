Items = Class{}

function Items:init(def)
    self.x = def.x
    self.y = def.y
    self.type = def.type
    self.quality = def.quality
    self.strength = def.stats_multiplier * math.random(0, 3) * def.quality
    self.intelligence = def.stats_multiplier * math.random(0, 3) * def.quality
    self.agility = def.stats_multiplier * math.random(0, 3) * def.quality
    self.block_chance = def.block_chance
    self.block_damage = def.block_damage
    self.damage = def.damage
    self.armor = def.armor
    self.renderTooltips = false
end

function Items:render(x, y)
    local rx = mouseInScreenX + (x + VIRTUAL_WIDTH / 2)
    local ry = mouseInScreenY + (y + VIRTUAL_HEIGHT / 2)
    love.graphics.draw(gTextures[self.type], x + self.x, y + self.y)
    if rx >= x + self.x  and rx <= x + self.x + 16 and
    ry >= y + self.y  and ry <= y + self.y + 16 then
        self.renderTooltips = true
    else
        self.renderTooltips = false
    end
end

function Items:renderTooltip(x, y)
    if self.renderTooltips then
        local tx = math.floor(mouseInScreenX + (x + VIRTUAL_WIDTH / 2)) + 3
        local ty = math.floor(mouseInScreenY + (y + VIRTUAL_HEIGHT / 2))
        local tooltipText = tostring(self.type)
        local heighMultiplier = 1
        tooltipText = tooltipText .. '\n'.. "Quality: " ..'  '.. tostring(self.quality) ..'\n'
        heighMultiplier = heighMultiplier + 1
        if self.damage ~= 0 then
            tooltipText = tooltipText .. "Damage: " ..'  '.. tostring(self.damage)..'\n'
            heighMultiplier = heighMultiplier + 1
        end
        if self.block_chance ~= 0 then
            tooltipText = tooltipText .. "Chance to block: " ..'  '.. tostring(self.block_chance)..'\n'
            tooltipText = tooltipText .. "Block " .. tostring(self.block_damage)..' incoming damage'..'\n'
            heighMultiplier = heighMultiplier + 2
        end
        if self.armor ~= 0 then
            tooltipText = tooltipText .."Armor: " ..'  '.. tostring(self.armor)..'\n'
            heighMultiplier = heighMultiplier + 1
        end
        if self.strength ~= 0 then
        tooltipText = tooltipText .."Strength: " ..'  '.. tostring(self.strength)..'\n'
        heighMultiplier = heighMultiplier + 1
        end
        if self.intelligence ~= 0 then
        tooltipText = tooltipText .."Intelligence: " ..'  '.. tostring(self.intelligence)..'\n'
        heighMultiplier = heighMultiplier + 1
        end
        if self.agility ~= 0 then
        tooltipText = tooltipText .."Agility: " ..'  '.. tostring(self.agility)..'\n'
        heighMultiplier = heighMultiplier + 1
        end
        local textWidth  = gFonts['small']:getWidth(tooltipText)
	    local textHeight = gFonts['small']:getHeight()
        love.graphics.setColor(0, 0, 0, 0.8)
        love.graphics.rectangle('fill',tx , ty, textWidth, textHeight * heighMultiplier, 3)
        love.graphics.setColor(0.2, 1, 0.2, 1)
        love.graphics.print(tooltipText, gFonts['small'], tx, ty)
        love.graphics.setColor(255, 255, 255, 1)
    end
end

