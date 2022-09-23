Interface = Class{}

function Interface:init(def)
    self.player = def.player
    self.class = 'warrior'
    self.x = def.x
    self.y = def.y
end

function Interface:render()
    50 177
    love.graphics.draw(gTextures['health', 50, 177])
    love.graphics.draw(gTextures['panel'],self.x,self.y)
end

function Interface:renderHealth()

    for i = 1, 100 do
        
end