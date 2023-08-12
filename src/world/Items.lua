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
    self.block_damage = def.block_damage and def.block_damage * def.quality or nil
    self.damage = def.damage and def.damage * def.quality or nil
end

function Items:render(x, y)
    love.graphics.draw(gTextures[self.type], x + self.x, y + self.y)
    if mouseInScreenX + (x + VIRTUAL_WIDTH / 2) >= x + self.x  and mouseInScreenX + (x + VIRTUAL_WIDTH / 2) <= x + self.x + 16 and
    mouseInScreenY + (y + VIRTUAL_HEIGHT / 2) >= y + self.y  and mouseInScreenY + (y + VIRTUAL_HEIGHT / 2)<= y + self.y + 16 then
        self:renderTooltip(math.floor(mouseInScreenX + (x + VIRTUAL_WIDTH / 2)), math.floor(mouseInScreenY + (y + VIRTUAL_HEIGHT / 2)))
    end
end

function Items:renderTooltip(x, y)
    love.graphics.setColor(0.2, 1, 0.2, 1)
    love.graphics.print("Quality: " ..'  '.. tostring(self.quality), gFonts['small'], x, y)
    love.graphics.print("Strength: " ..'  '.. tostring(self.strength), gFonts['small'], x, y + 8)
    love.graphics.print("Intelligence: " ..'  '.. tostring(self.intelligence), gFonts['small'], x, y + 16)
    love.graphics.print("Agility: " ..'  '.. tostring(self.agility), gFonts['small'], x, y + 24)
    love.graphics.setColor(255, 255, 255, 1)
end