Inventory = Class{__includes = BaseState}

function Inventory:init(player, energy)
    self.player = player
    self.energy = energy
    self.x = math.floor(self.player.x - VIRTUAL_WIDTH / 2)
    self.y = math.floor(self.player.y - VIRTUAL_HEIGHT / 2)
end


function Inventory:render()
    local x = self.x
    local y = self.y



    local frame = 2
    love.graphics.draw(gTextures['inventory'],x, y)
    love.graphics.print('Available points: '..tostring(self.player.bonusPoints),gFonts['small'], x + 76, y + 110)
    love.graphics.print('Strength:    '..tostring(self.player.totalStrength),gFonts['small'], x + 66, y + 122)
    love.graphics.print('Agility:       '..tostring(self.player.totalAgility),gFonts['small'], x + 66, y + 134)
    love.graphics.print('Intelligence: '..tostring(self.player.totalIntelligence),gFonts['small'], x + 66, y + 145)
    love.graphics.print(tostring(self.energy)..' regeneration: '..tostring(self.player.regenEnergy),gFonts['small'], x + 66, y + 156)
    love.graphics.print(string.format('%4s', tostring(self.player.gold)), gFonts['small'], x + 300, y + 160)
    
    if self.player.bonusPoints > 0 then
        frame = 1
    end
    love.graphics.draw(gTextures['plus'], gFrames['plus'][frame],x + 132, y + 120)
    love.graphics.draw(gTextures['plus'], gFrames['plus'][frame],x + 132, y + 132)
    love.graphics.draw(gTextures['plus'], gFrames['plus'][frame],x + 132, y + 144)
    self.player:renderItems()
    self:tips(self.x, self.y)
end


function Inventory:tips(x, y)
    if (mx > 64 and mx < 144) and (my > 121 and my < 132) then
        love.graphics.print('Strength: your melee attack deal more physical\n damage',gFonts['small'], x + 88, y + 175)
    elseif (mx > 64 and mx < 144) and (my > 133 and my < 143) then
        love.graphics.print('Agility: your ranged attack deals more physical\n damage and also increases your attack speed.',gFonts['small'], x + 88, y + 175)
    elseif (mx > 64 and mx < 144) and (my > 144 and my < 155) then
        love.graphics.print('Intelligence: affects the maximum amount of mana\n and its regeneration',gFonts['small'], x + 88, y + 175)
    end
end

function Inventory:update(dt)
    self.player:calculateStats()
        if self.player.bonusPoints > 0 then
            if love.mouse.wasPressed(1) and (mx > 132 and mx < 143) and (my > 120 and my < 131) then
                self.player.strength = self.player.strength + 1
                self.player.bonusPoints = math.max(0, self.player.bonusPoints - 1)
            elseif love.mouse.wasPressed(1) and (mx > 132 and mx < 143) and (my > 132 and my < 143) then
                self.player.agility = self.player.agility + 1
                self.player.bonusPoints = math.max(0, self.player.bonusPoints - 1)
            elseif love.mouse.wasPressed(1) and (mx > 132 and mx < 143) and (my > 143 and my < 154) then
                self.player.intelligence = self.player.intelligence + 1
                self.player.bonusPoints = math.max(0, self.player.bonusPoints - 1)
            end
        end

        if love.keyboard.wasPressed('escape') or love.keyboard.wasPressed('c') then
            gStateStack:pop()
        end
end

