TalentTree = Class{__includes = BaseState}

function TalentTree:init(player)
    self.player = player
    self.spells = {}
    for i = 1 , #self.player.spells do
        self.spells[i] = {
            level,
            playerCanImprove
        }
        self.spells[i].level = self.player.spells[i].level
        self.spells[i].playerCanImprove = self.player.spells[i].playerCanImprove
    end
    self.points = self.player.talentPoints
    self.x = math.floor(self.player.x - VIRTUAL_WIDTH / 2)
    self.y = math.floor(self.player.y - VIRTUAL_HEIGHT / 2)
    self.grabbedSkill = 0
end


function TalentTree:render()
    
        love.graphics.draw(gTextures['talent_tree'], self.x, self.y)
        love.graphics.print(tostring(self.points)..'  points to upgrade available.',gFonts['small'], self.x + 100, self.y + 160)
        if (mx > 252 and mx < 283) and (my > 157 and my < 168) then
            love.graphics.setColor(0, 0,  255, 0.2)
            love.graphics.rectangle('fill', self.x + 253, self.y + 158, 30, 10) 
        elseif (mx > 288 and mx < 318) and (my > 157 and my < 168) then
            love.graphics.setColor(0, 0, 255, 0.2)
            love.graphics.rectangle('fill', self.x + 289, self.y + 158, 29, 10) 
        elseif (mx > 323 and mx < 347) and (my > 157 and my < 168) then
            love.graphics.setColor(0, 0, 255, 0.2)
            love.graphics.rectangle('fill', self.x + 324, self.y + 158, 23, 10) 
        end

        love.graphics.setColor(255, 255, 255, 1)
        love.graphics.print('Cancel',gFonts['small'], self.x + 255, self.y + 160)
        love.graphics.print('Accept',gFonts['small'], self.x + 290, self.y + 160)
        love.graphics.print('Close',gFonts['small'], self.x + 326, self.y + 160)

        for i = 1, #self.player.spells do
            local canLearn =  self.spells[i].playerCanImprove > self.player.spells[i].level and self.points > 0 and
            self.player.playerlevel >= self.player.spells[i].require
            love.graphics.draw(gTextures['plus'], gFrames['plus'][canLearn and 1 or 2],
            self.x + self.player.spells[i].x + 17, self.y + self.player.spells[i].y+2)
            if self.spells[i].level < 1 then
                love.graphics.setColor(255, 255, 255, 0.2)
            else
                love.graphics.setColor(255, 255, 255, 1)
            end
            
            love.graphics.draw(gTextures[tostring(self.player.class)..'_spells'],
                gFrames[tostring(self.player.class)..'_spells'][self.player.spells[i].id], self.x + self.player.spells[i].x, self.y + self.player.spells[i].y)
                love.graphics.print(tostring(self.spells[i].level), gFonts['small'], self.x + self.player.spells[i].x + 12, self.y + self.player.spells[i].y + 12)
            love.graphics.setColor(255, 255, 255, 1)
        end

        love.graphics.setColor(255, 255, 255, 1)

        if self.grabbedSkill > 0 then
            love.graphics.draw(gTextures[tostring(self.player.class)..'_spells'],
            gFrames[tostring(self.player.class)..'_spells'][self.grabbedSkill], math.floor(self.x + mx), math.floor(self.y + my))
        end

        self:renderTips()
    
end

function TalentTree:update(dt)
    for i = 1 , #self.player.spells do
            
        if self.points > 0 then
            if love.mouse.wasPressed(1) and (mx > self.player.spells[i].x + 17 and mx < self.player.spells[i].x + 32) and 
            (my > self.player.spells[i].y and my < self.player.spells[i].y + 15) and self.spells[i].playerCanImprove > 0 then
                if self.player.playerlevel >= self.player.spells[i].require then
                    self.spells[i].level = self.spells[i].level + 1
                    self.points = self.points - 1
                    self.spells[i].playerCanImprove = self.spells[i].playerCanImprove - 1
                else
                    wrongAction()
                end
            end
        end
        if (mx > self.player.spells[i].x and mx < self.player.spells[i].x + 15) and 
            (my > self.player.spells[i].y and my < self.player.spells[i].y + 15)  and
            self.player.spells[i].level > 0  and not self.player.spells[i].isPassive
            and love.mouse.isDown(1) then     
                self.grabbedSkill = self.player.spells[i].id
        end
    end

    if (mx > 252 and mx < 283) and (my > 157 and my < 168) and love.mouse.wasPressed(1) then 
        self.points = self.player.talentPoints
        for i = 1 , #self.player.spells do
            self.spells[i].level = self.player.spells[i].level
            self.spells[i].playerCanImprove = self.player.spells[i].playerCanImprove
        end
    elseif (mx > 288 and mx < 318) and (my > 157 and my < 168) and love.mouse.wasPressed(1) then
        self.player.talentPoints = self.points
        for i = 1 , #self.player.spells do
            self.player.spells[i].level = self.spells[i].level 
            self.player.spells[i].playerCanImprove = self.spells[i].playerCanImprove
        end
    end
    if love.mouse.wasReleased(1) then
        if self.grabbedSkill > 0 then
            for i = 1, 4 do
                if ((mx > 90 + (i-1) * 20) and (mx < 90 + i * 20)) and (my > 195 and my < 215) then
                    self.player.spellPanel[i] = self.grabbedSkill
                    for j = 1, 4 do
                        if self.player.spellPanel[j] == self.grabbedSkill and i ~= j   then
                            self.player.spellPanel[j] = 0
                        end
                    end
                end
            end
        end
        self.grabbedSkill = 0
    end

    if ((mx > 323 and mx < 347) and (my > 157 and my < 168) and love.mouse.wasPressed(1)) or
    love.keyboard.wasPressed('escape') or love.keyboard.wasPressed('v') then
        gStateStack:pop()
    end
end

function TalentTree:renderTips()
    for i = 1 , #self.player.spells do
        local x = self.x + self.player.spells[i].x + 18
        local y = self.y + self.player.spells[i].y
        local yMargin = -6
            for k, v in pairs(ENTITY_SPELLS['player'][self.player.class][self.player.spells[i].name]) do
                if v then
                    yMargin = yMargin + 1
                end
            end

        love.graphics.print(tostring(yMargin), gFonts['medium'], self.x + 10, self.y)
        if (mx > self.player.spells[i].x and mx < self.player.spells[i].x + 15) 
        and (my > self.player.spells[i].y and my < self.player.spells[i].y + 15) then
            local tooltipText = '"'..tostring(self.player.spells[i].name)..'"'.."\n"
            local heighMultiplier = 2
            if ENTITY_SPELLS['player'][self.player.class][self.player.spells[i].name].isPassive then
                heighMultiplier = heighMultiplier + 1
                tooltipText = tooltipText .. 'passive talent'..'\n'
            end
            tooltipText = tooltipText .. ENTITY_SPELLS['player'][self.player.class][self.player.spells[i].name].description .. "\n"
            if self.player.spells[i].range > 0 then
                tooltipText = tooltipText .. 'range: '..tostring(self.player.spells[i].range) ..'\n'
                heighMultiplier = heighMultiplier + 1
            end
            if self.player.spells[i].cost > 0 then
                tooltipText = tooltipText .. 'cost: '..tostring(self.player.spells[i].cost) ..'\n'
                heighMultiplier = heighMultiplier + 1
            end
            if self.player.spells[i].energy > 0 then
                tooltipText = tooltipText .. 'gain '..tostring(self.player.spells[i].energy)..' '..tostring(self.player.energyBar) .."\n"
                heighMultiplier = heighMultiplier + 1
            end     
            if self.player.spells[i].damage > 0 then
                tooltipText = tooltipText .. 'damage: '..tostring(self.player.spells[i].damage * self.spells[i].level)..' + '..
                tostring(self.player.spells[i].scale * self.player.spells[i].mainStat)..' ('..self.player.spells[i].mainStatString..')'.. "\n"
                heighMultiplier = heighMultiplier + 1
            end
            if self.player.spells[i].effectToTarget then
                tooltipText = tooltipText .. 'apply on enemy: '..tostring(self.player.spells[i].effectToTarget).. "\n"
                heighMultiplier = heighMultiplier + 1
                if self.player.spells[i].effectPower > 0 then
                    tooltipText = tooltipText .. 'deal: '..tostring(self.player.spells[i].effectPower)
                    ..' + '..tostring((self.player.spells[i].level * self.player.spells[i].effectPower + self.player.spells[i].scale * self.player.spells[i].mainStat) / self.player.spells[i].duration)
                    ..' ('..tostring(self.player.spells[i].mainStatString)..')'.. "\n"
                    heighMultiplier = heighMultiplier + 1
                end          
            end
            if self.player.spells[i].effectToSelf then
                tooltipText = tooltipText .. 'apply on self: '..tostring(self.player.spells[i].effectToSelf).."\n"
                heighMultiplier = heighMultiplier + 1
                if self.player.spells[i].effectPower > 0 then
                    tooltipText = tooltipText ..'get: '..tostring(self.player.spells[i].effectPower)..' + '..
                    tostring((self.player.spells[i].level * self.player.spells[i].effectPower + self.player.spells[i].scale * self.player.spells[i].mainStat) / self.player.spells[i].duration).."\n"
                    heighMultiplier = heighMultiplier + 1
                end
            end
            if self.player.spells[i].duration > 0 then
                tooltipText = tooltipText ..'duration: '..tostring(self.player.spells[i].duration).. ' s'.."\n"
                heighMultiplier = heighMultiplier + 1
            end
            if self.player.spells[i].aoe > 0 then
                tooltipText = tooltipText ..'affected area: '..tostring(self.player.spells[i].aoe)..' cell around target'.."\n"
                heighMultiplier = heighMultiplier + 1
            end
            if self.player.spells[i].cooldown > 0 then
                tooltipText = tooltipText ..'cooldown: '..tostring(self.player.spells[i].cooldown)..' s'.."\n"
                heighMultiplier = heighMultiplier + 1
            end
            tooltipText = tooltipText ..'learned: '..tostring((ENTITY_SPELLS['player'][self.player.class][self.player.spells[i].name].playerCanImprove - self.spells[i].playerCanImprove))
            ..'/'..tostring(ENTITY_SPELLS['player'][self.player.class][self.player.spells[i].name].playerCanImprove).."\n"
            heighMultiplier = heighMultiplier + 3
            local textWidth  = gFonts['small']:getWidth(tooltipText)
            local textHeight = gFonts['small']:getHeight()
            love.graphics.setColor(0, 0, 0, 0.8)
            love.graphics.rectangle('fill',x , y, textWidth, textHeight * heighMultiplier, 3)
            if ENTITY_SPELLS['player'][self.player.class][self.player.spells[i].name].require > self.player.playerlevel then
                love.graphics.setColor(1, 0, 0, 1)
            else
                love.graphics.setColor(0.2, 1, 0.2, 1)
            end
            love.graphics.print('require level ' .. ENTITY_SPELLS['player'][self.player.class][self.player.spells[i].name].require, gFonts['small'], x, y)
            love.graphics.setColor(0.2, 1, 0.2, 1)
            love.graphics.print(tooltipText, gFonts['small'], x, y + 8)
            love.graphics.setColor(255, 255, 255, 1)
            end
    end
end