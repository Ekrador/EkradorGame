TalentTree = Class{}

function TalentTree:init(player)
    self.player = player
    self.visible = false
end

function TalentTree:togle()
    if self.visible then
        self.visible = false
    else
        self.visible = true
    end
end


function TalentTree:render(x, y)
    if self.visible then
        love.graphics.draw(gTextures['talent_tree'], x, y)
        for k, spell in pairs(self.player.spells) do
            if spell.level < 1 then
                love.graphics.setColor(255, 255, 255, 1)
            else
                love.graphics.setColor(255, 255, 255, 1)
            love.graphics.draw(gTextures[tostring(self.player.class)..'_spells'],
                gFrames[tostring(self.player.class)..'_spells'][spell.id],x + spell.x, y + spell.y)
            end
        end
        love.graphics.setColor(255, 255, 255, 1)
    end
end