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
    --tips render
end

