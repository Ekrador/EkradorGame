
PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(entity, level)
    EntityWalkState.init(self, entity)
    self.level = level
    self.mx = self.entity.mouseInScreenX
    self.my = self.entity.mouseInScreenY
    self.direction = 1
end
  
function PlayerWalkState:update(dt)
    if love.keyboard.isDown('lshift') then
        if (self.mx > self.entity.width) and (self.my < self.entity.height / 2) then
            self.entity.direction = 'up-right'
        elseif (self.mx > self.entity.width) and (self.my > self.entity.height / 2 and
        self.my < self.entity.height)  then
            self.entity.direction = 'right'
        elseif self.mx > self.entity.width and self.my > self.entity.height then
            self.entity.direction = 'down-right'
        elseif (self.mx > 0 and self.mx < self.entity.width) and (self.my > self.entity.height / 2) then
            self.entity.direction = 'down'
        elseif (self.mx < 0) and (self.my > self.entity.height) then
            self.entity.direction = 'down-left'
        elseif (self.mx < 0) and (self.my > self.entity.height / 2 and
        self.my < self.entity.height) then
            self.entity.direction = 'left'
        elseif (self.mx < 0) and (self.my < self.entity.height / 2) then
            self.entity.direction = 'up-left'
        elseif (self.mx > 0 and self.mx < self.entity.width) and (self.my < self.entity.height / 2) then
            self.entity.direction = 'up'
        end
        self.entity:changeState('attack')

    elseif (love.mouse.wasPressed(2) or love.mouse.wasReleased(2)) and 
    (mouseTileY > 0 and mouseTileY < self.level.mapSize) and (mouseTileX > 0 and mouseTileX < self.level.mapSize) and
    not self.level.map.tiles[mouseTileY][mouseTileX]:collidable() then
        self.entity.getCommand = false   
        self.entity.path = self.entity:pathfind{
            startX = self.entity.mapX,
            startY = self.entity.mapY,
            endX = mouseTileX,
            endY = mouseTileY
        }
        if self.entity.path then             
            if not self.entity.getCommand then
                self.entity.getCommand = true
                self:move(self.entity.path, 1)
            else 
                self.entity.stop = true
            end
        end
    else
        if not self.entity.getCommand then
            self.entity:changeState('idle')
        end
    end
end

