
PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(entity, level)
    EntityWalkState.init(self, entity)
    self.level = level
end
  
function PlayerWalkState:update(dt)
    if love.mouse.wasPressed(2) or love.mouse.wasReleased(2) then  
        self.entity.getCommand = false    
        if myy > 0 and myy < self.level.mapSize 
        and mxx > 0 and mxx < self.level.mapSize and
        not self.level.map.tiles[myy][mxx]:collidable() then
            path = self.entity:pathfind{
                startX = self.entity.mapX,
                startY = self.entity.mapY,
                endX = mxx,
                endY = myy
            }
            if path then             
                if not self.entity.getCommand then
                    self.entity.getCommand = true
                    self:move(path, 1)
                else 
                    self.entity.stop = true
                end
            end
        end
    else
        if not self.entity.getCommand then
            self.entity:changeState('idle')
        end
    end
end

function PlayerWalkState:move(path, i)
    if self.entity.stop then
        self.entity.stop = false
        self.entity.getCommand = false
        return 
    end

    if i > #path then
        self.entity.getCommand = false
        return
    end
    newX = (path[i].x-1)*0.5*self.entity.width + (path[i].y-1)*-1*self.entity.width*0.5
    newY = (path[i].x-1)*0.5*GROUND_HEIGHT+ (path[i].y-1)*0.5*GROUND_HEIGHT - self.entity.height + GROUND_HEIGHT
    Timer.tween(1 / self.entity.speed,{
        [self.entity] = { x = newX, y = newY }
    })  
    :finish(function() self:move(path, i + 1) end)
end

