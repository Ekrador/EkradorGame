ITEMS_DEFS = {
    ['shield'] = function()
        return {
            stats_multiplier = 1,
            armor = math.random(3, 15),
            damage = 0,
            block_chance = math.random(30),
            block_damage = math.random(1, 10)
        }
    end,
    ['weapon'] = function()
        return {
            stats_multiplier = 2,
            armor = 0,
            damage = math.random(6),
            block_chance = 0,
            block_damage = 0
        }
    end,
    ['head'] = function()
        return {
        stats_multiplier = 1,
        armor = math.random(2, 4),
        damage = 0,
        block_chance = 0,
        block_damage = 0
        }
    end, 
    ['chest'] = function()
        return {
        stats_multiplier = 2,
        armor = math.random(3, 5),
        damage = 0,
        block_chance = 0,
        block_damage = 0
        }
    end,
    ['gloves'] = function()
        return {
        stats_multiplier = 1,
        armor = math.random(1, 2),
        damage = 0,
        block_chance = 0,
        block_damage = 0
        }
    end,
    ['legs'] = function()
        return {
        stats_multiplier = 2,
        armor = math.random(1, 5),
        damage = 0,
        block_chance = 0,
        block_damage = 0
        }
    end,
    ['boots'] = function()
        return {
        stats_multiplier = 1,
        armor = math.random(0, 2),
        damage = 0,
        block_chance = 0,
        block_damage = 0
        }
    end,
    ['neck'] = function()
        return {
        stats_multiplier = 3,
        armor = 0,
        damage = 0,
        block_chance = 0,
        block_damage = 0
        }
    end,
    ['ring'] = function()
        return {
        stats_multiplier = 2,
        armor = 0,
        damage = 0,
        block_chance = 0,
        block_damage = 0
        }
    end,
}