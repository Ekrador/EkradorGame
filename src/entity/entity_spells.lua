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
                range = 7,
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
                isPassive = false,
                description = 'rapidly moves you towards a target\n and stun it',
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
                    player.step:remove()
                    player.getCommand = true
                    player:move(path, 10)
                end
            },
            ['spin attack'] = {
                name = 'spin attack',
                id = 2,
                x = 73,
                y = 58,
                require = 2,
                level = 0,
                playerCanImprove = 2,
                damage = 100,
                range = 1,
                cost = 50,
                energy = 0,
                scale = 5,
                duration = 0,
                debuff = nil,
                buff = nil,
                aoe = 1,
                effectPower = 0,
                cooldown = 20,
                target = 'self',
                isProjectile = false,
                isPassive = false,
                description = 'swing the weapon around you,\n damage nearby enemies',
                onUse = function(player, target, map)
                end,
                sound = function ()
                    gSounds['sword_swing']:stop()
                    gSounds['sword_swing']:play()  
                end

            },
            ['anger'] = {
                name = 'anger',
                id = 3,
                x = 104,
                y = 85,
                require = 3,
                level = 0,
                playerCanImprove = 1,
                damage = 0,
                range = 0,
                cost = 0,
                energy = 0,
                scale = 1,
                duration = 0,
                debuff = nil,
                buff = nil,
                aoe = 0,
                effectPower = 0,
                cooldown = 0,
                target = 'self',
                isProjectile = false,
                isPassive = true,
                description = 'gives your attacks additional damage\n based on the amount of rage, up to 30%',
                onUse = function(player)
                    player.damage = player.damage * (1 + player.currentEnergy / player.maxEnergy * 0.3)
                end
            },
            ['fatal blows'] = {
                name = 'fatal blows',
                id = 4,
                x = 104,
                y = 125,
                require = 3,
                level = 0,
                playerCanImprove = 1,
                damage = 0,
                range = 0,
                cost = 0,
                energy = 0,
                scale = 1,
                duration = 0,
                debuff = nil,
                buff = nil,
                aoe = 0,
                effectPower = 0,
                cooldown = 0,
                target = 'self',
                isProjectile = false,
                isPassive = true,
                description = 'gives your attacks chance to deal\n critical damage depending on rage amount up to 20% chance',
                onUse = function(player)
                    local critChance = player.currentEnergy / player.maxEnergy * 20
                    local critical = math.random(100) <= critChance
                    player.damage = critical and player.damage*2 or player.damage
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
                    speed = 70,
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