ENTITY_SPELLS = {
    ['player'] = {
        ['warrior'] = {
            ['charge'] = {
                name = 'charge',
                id = 1,
                x = 43,
                y = 27,
                require = 1,
                scale = 1,
                level = 0,
                playerCanImprove = 3,
                damage = 5,
                range = 4,
                cost = 0,
                energy = 20,
                duration = 3.5,
                debuff = 'stun',
                buff = nil,
                aoe = 0,
                effectPower = 0,
                cooldown = 10,
                target = 'enemy',
                isProjectile = false,
                onUse = function(player, target, map)
                    local path = player:pathfind{
                        startX = player.mapX,
                        startY = player.mapY,
                        endX = target.mapX,
                        endY = target.mapY
                    }
                    if path == nil then
                        return
                    end
                    player.actionsQueue = {}
                    player.getCommand = true
                    player:move(path, 10)
                end
            },
        },
        ['mage'] = {

        },
        ['ranger'] = {
            
        }
    },
    ['Lich'] = {
        ['pyroblast'] ={
            name = 'pyroblast',
            damage = 200,
            range = 8,
            level = 1,
            scale = 1,
            mainStat = 1,
            cooldown = 15,
            aoe = 0,
            duration = 5,
            target = 'enemy',
            debuff = 'ignite',
            buff = nil,
            effectPower = 100,
            isProjectile = true,
            speed = 0.5,
            onUse = function(entity, target, map)
                table.insert(map.projectiles, Projectile {
                    type = 'pyroblast',
                    mapX = entity.mapX,
                    mapY = entity.mapY,
                    endPointX = map.player.x,
                    endPointY = map.player.y,
                    damage = 200,
                    speed = 35,
                    x = entity.x + entity.width/2,
                    y = entity.y + entity.height/2,
                })
            end
        },
        ['riseSkeletons']={
            name = 'riseSkeletons',
            damage = 0,
            range = 8,
            level = 1,
            scale = 1,
            mainStat = 1,
            cooldown = 60,
            aoe = 0,
            target = 'self',
            isProjectile = false,
            speed = 1,
            onUse = function(entity, target, map)
                local types = {'skeleton', 'skeleton-archer'}
                local startX = entity.mapX - 4 >= 1 and entity.mapX - 4 or 1
                local endX = entity.mapX + 4 >= map.mapSize and map.mapSize or entity.mapX + 4
                local startY = entity.mapY - 4 >= 1 and entity.mapY - 4 or 1
                local endY = entity.mapY + 4 >= map.mapSize and map.mapSize or entity.mapY + 4
                map:generateEntities(types, 3, startX, startY, endX,  endY, false)
            end
        }

    }
}