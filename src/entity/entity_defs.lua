--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

ENTITY_DEFS = {
    ['player'] = {
        animations = {
            ['walk-up-right'] = {
                frames = {17, 18},
                interval = 0.15,
                texture = 'player'
            },
            ['walk-right'] = {
                frames = {8, 9},
                interval = 0.15,
                texture = 'player'
            },
            ['walk-down-right'] = {
                frames = {23, 24},
                interval = 0.15,
                texture = 'player'
            },
            ['walk-down'] = {
                frames = {2, 3},
                interval = 0.15,
                texture = 'player'
            },
            ['walk-down-left'] = {
                frames = {20, 21},
                interval = 0.15,
                texture = 'player'
            },
            ['walk-left'] = {
                frames = {5, 6},
                interval = 0.15,
                texture = 'player'
            },
            ['walk-up-left'] = {
                frames = {14, 15},
                interval = 0.15,
                texture = 'player'
            },
            ['walk-up'] = {
                frames = {11, 12},                          
                interval = 0.15,
                texture = 'player'
            },
            ['idle-up-right'] = {
                frames = {16},
                texture = 'player'
            },
            ['idle-right'] = {
                frames = {7},
                texture = 'player'
            },
            ['idle-down-right'] = {
                frames = {22},
                texture = 'player'
            },
            ['idle-down'] = {
                frames = {1},
                texture = 'player'
            },
            ['idle-down-left'] = {
                frames = {19},
                texture = 'player'
            },
            ['idle-left'] = {
                frames = {4},
                texture = 'player'
            },
            ['idle-up-left'] = {
                frames = {13},
                texture = 'player'
            },
            ['idle-up'] = {
                frames = {10},
                texture = 'player'
            },
            ['attack-up-right'] = {
                frames = {16, 17, 18},
                interval = 0.15,
                texture = 'player'
            },
            ['attack-right'] = {
                frames = {7, 8, 9},
                interval = 0.15,
                texture = 'player'
            },
            ['attack-down-right'] = {
                frames = {22, 23, 24},
                interval = 0.15,
                texture = 'player'
            },
            ['attack-down'] = {
                frames = {1, 2, 3 },
                interval = 0.15,
                texture = 'player'
            },
            ['attack-down-left'] = {
                frames = {19, 20, 21},
                interval = 0.15,
                texture = 'player'
            },
            ['attack-left'] = {
                frames = {4, 5, 6},
                interval = 0.15,
                texture = 'player'
            },
            ['attack-up-left'] = {
                frames = {13, 14, 15},
                interval = 0.15,
                texture = 'player'
            },
            ['attack-up'] = {
                frames = {10, 11, 12},                          
                interval = 0.15,
                texture = 'player'
            }
        },
        speed = 2,
        health = 100,
        attackRange = 1,
        damage = 10
    },
    ['skeleton'] = {
        animations = {
            ['walk-up-right'] = {
                frames = {2, 3},
                interval = 0.15,
                texture = 'skeleton'
            },
            ['walk-right'] = {
                frames = {5, 6},
                interval = 0.15,
                texture = 'skeleton'
            },
            ['walk-down-right'] = {
                frames = {8, 9},
                interval = 0.15,
                texture = 'skeleton'
            },
            ['walk-down'] = {
                frames = {11, 12 },
                interval = 0.15,
                texture = 'skeleton'
            },
            ['walk-down-left'] = {
                frames = {14, 15},
                interval = 0.15,
                texture = 'skeleton'
            },
            ['walk-left'] = {
                frames = {17, 18},
                interval = 0.15,
                texture = 'skeleton'
            },
            ['walk-up-left'] = {
                frames = {20, 21},
                interval = 0.15,
                texture = 'skeleton'
            },
            ['walk-up'] = {
                frames = {23, 24},                          
                interval = 0.15,
                texture = 'skeleton'
            },
            ['idle-up-right'] = {
                frames = {1},
                texture = 'skeleton'
            },
            ['idle-right'] = {
                frames = {4},
                texture = 'skeleton'
            },
            ['idle-down-right'] = {
                frames = {7},
                texture = 'skeleton'
            },
            ['idle-down'] = {
                frames = {10},
                texture = 'skeleton'
            },
            ['idle-down-left'] = {
                frames = {13},
                texture = 'skeleton'
            },
            ['idle-left'] = {
                frames = {16},
                texture = 'skeleton'
            },
            ['idle-up-left'] = {
                frames = {19},
                texture = 'skeleton'
            },
            ['idle-up'] = {
                frames = {22},
                texture = 'skeleton'
            },
            ['attack-up-right'] = {
                frames = {1, 2, 3},
                interval = 0.15,
                texture = 'skeleton'
            },
            ['attack-right'] = {
                frames = {4, 5, 6},
                interval = 0.15,
                texture = 'skeleton'
            },
            ['attack-down-right'] = {
                frames = {7, 8, 9},
                interval = 0.15,
                texture = 'skeleton'
            },
            ['attack-down'] = {
                frames = {10, 11, 12},
                interval = 0.15,
                texture = 'skeleton'
            },
            ['attack-down-left'] = {
                frames = {13, 14, 15},
                interval = 0.15,
                texture = 'skeleton'
            },
            ['attack-left'] = {
                frames = {16, 17, 18},
                interval = 0.15,
                texture = 'skeleton'
            },
            ['attack-up-left'] = {
                frames = {19, 20, 21},
                interval = 0.15,
                texture = 'skeleton'
            },
            ['attack-up'] = {
                frames = {22, 23, 24},                          
                interval = 0.15,
                texture = 'skeleton'
            }
        },
        speed = 1,
        health = 20,
        agroRange = 6,
        attackRange = 1,
        damage = 5
    }
}