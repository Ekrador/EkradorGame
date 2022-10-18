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
                onUse = function(player, target)
                    local path = player:pathfind{
                        startX = player.mapX,
                        startY = player.mapY,
                        endX = target.mapX,
                        endY = target.mapY
                    }
                    player:move(path, 1, 10)
                end
            },
        },
        ['mage'] = {

        },
        ['ranger'] = {
            
        }
    },
    ['skeleton'] = {

    }
}