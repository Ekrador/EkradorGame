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
    },
    ['warrior'] = {
        regenEnergy = -2,
        regenHp = 1,
        currentEnergy = 0,
        regenRate = 1,
        strength = 5,
        agility = 3,
        intelligence = 1
    },
    ['mage'] = {
        regenEnergy = 1,
        regenHp = 3,
        currentEnergy = 100,
        regenRate = 5,
        strength = 1,
        agility = 2,
        intelligence = 6
    },
    ['ranger'] = {
        regenEnergy = 10,
        regenHp = 1,
        currentEnergy = 100,
        regenRate = 2,
        strength = 2,
        agility = 5,
        intelligence = 1
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
        name = 'skeleton',
        speed = 20,
        health = 200,
        agroRange = 6,
        attackRange = 1,
        damage = 5
    },
    ['skeleton-archer'] = {
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
        name = 'skeleton-archer',
        speed = 15,
        health = 200,
        agroRange = 6,
        attackRange = 5,
        damage = 35,
        projectileType = 'arrow',
        projectileSpeed = 35,
        attackSpeed = 0.1,
    },
    ['Lich'] = {
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
        name = 'Lich',
        speed = 15,
        health = 200,
        agroRange = 6,
        attackRange = 5,
        damage = 35,
        projectileType = 'fireball',
        projectileSpeed = 35,
        attackSpeed = 0.1,
    }
}