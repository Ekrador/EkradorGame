Projectile = Class{}

function Projectile:init(def)
    self.type = def.type
    self.mapX = def.mapX
    self.mapY = def.mapY
    self.endPointX = def.endPointX + 16
    self.endPointY = def.endPointY + 17
    self.damage = def.damage
    self.speed = def.speed
    self.x = def.x 
    self.y = def.y 
    self.dir = math.atan2(self.endPointY - self.y,self.endPointX - self.x)
    self.particle = def.particle
    gSounds[tostring(self.type)..'_shot']:stop()
    gSounds[tostring(self.type)..'_shot']:play() 

    if(gTextures[tostring(self.type)..'_particle'] ~= nil) then
        self.particleSystem = love.graphics.newParticleSystem(gTextures[tostring(self.type)..'_particle'], 6)
        self.particleSystem:setParticleLifetime(0.5, 1)
        self.particleSystem:setSpeed(self.speed)
        self.particleSystem:setEmissionRate(6)
    end
end

function Projectile:update(dt)
    local ax = self.speed * dt * math.cos(self.dir)
    local ay = self.speed * dt * math.sin(self.dir)
    self.x = self.x + ax
    self.y = self.y + ay
    if(self.particleSystem ~= nil) then
        local angle = math.atan2(-ay, -ax)
        self.particleSystem:setPosition(self.x + gTextures[self.type]:getWidth()*ax/2, self.y+ gTextures[self.type]:getHeight()*ay/2)
        self.particleSystem:setDirection(angle)
        self.particleSystem:setRotation(self.dir)
        self.particleSystem:setSpread(0.8)
        self.particleSystem:update(dt)
    end
    if math.abs(math.sin(self.dir)) == 1 then
    self.mapX, self.mapY = self:to_grid_coordinate(self.x - 16, self.y + math.sin(self.dir)*16) 
    elseif math.cos(self.dir) < 0 then 
        self.mapX, self.mapY = self:to_grid_coordinate(self.x + math.cos(self.dir)*32, self.y + math.sin(self.dir)*16) 
    elseif math.cos(self.dir) > 0 then
        self.mapX, self.mapY = self:to_grid_coordinate(self.x , self.y + math.sin(self.dir)*16) 
    end
end

function Projectile:render()
    love.graphics.draw(gTextures[self.type],math.floor(self.x), math.floor(self.y), self.dir)
    if(self.particleSystem ~= nil) then
        love.graphics.draw( self.particleSystem, x, y)    
    end
end

function Projectile:to_grid_coordinate(x,y) 
    local a = 1 * 0.5 * 32
    local b = -1 * 0.5 * 32
    local c =  0.5 * 16
    local d =  0.5 * 16
    
    inv = invert_matrix(a, b, c, d)
    local invertX
    local invertY
    
    --player.height
    invertX = math.floor(x* inv.a + (y+8)  * inv.b + 1)
    invertY = math.floor(x * inv.c + (y+8) * inv.d + 1)
    
    return invertX, invertY
end

function Projectile:hit()
    gSounds[tostring(self.type)..'_hit']:stop()
    gSounds[tostring(self.type)..'_hit']:play() 
end