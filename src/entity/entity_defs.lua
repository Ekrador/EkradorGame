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
                interval = 0.25,
                texture = 'player_attack'
            },
            ['attack-right'] = {
                frames = {7, 8, 9},
                interval = 0.25,
                texture = 'player_attack'
            },
            ['attack-down-right'] = {
                frames = {22, 23, 24},
                interval = 0.25,
                texture = 'player_attack'
            },
            ['attack-down'] = {
                frames = {1, 2, 3 },
                interval = 0.25,
                texture = 'player_attack'
            },
            ['attack-down-left'] = {
                frames = {19, 20, 21},
                interval = 0.25,
                texture = 'player_attack'
            },
            ['attack-left'] = {
                frames = {4, 5, 6},
                interval = 0.25,
                texture = 'player_attack'
            },
            ['attack-up-left'] = {
                frames = {13, 14, 15},
                interval = 0.25,
                texture = 'player_attack'
            },
            ['attack-up'] = {
                frames = {10, 11, 12},                          
                interval = 0.25,
                texture = 'player_attack'
            }
        },
        speed = 2,
        health = 100,
        attackRange = 1,
    },
    ['warrior'] = {
        regenEnergy = -2,
        regenHp = 2,
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
                interval = 0.25,
                texture = 'skeleton_attack'
            },
            ['attack-right'] = {
                frames = {4, 5, 6},
                interval = 0.25,
                texture = 'skeleton_attack'
            },
            ['attack-down-right'] = {
                frames = {7, 8, 9},
                interval = 0.25,
                texture = 'skeleton_attack'
            },
            ['attack-down'] = {
                frames = {10, 11, 12},
                interval = 0.25,
                texture = 'skeleton_attack'
            },
            ['attack-down-left'] = {
                frames = {13, 14, 15},
                interval = 0.25,
                texture = 'skeleton_attack'
            },
            ['attack-left'] = {
                frames = {16, 17, 18},
                interval = 0.25,
                texture = 'skeleton_attack'
            },
            ['attack-up-left'] = {
                frames = {19, 20, 21},
                interval = 0.25,
                texture = 'skeleton_attack'
            },
            ['attack-up'] = {
                frames = {22, 23, 24},                          
                interval = 0.25,
                texture = 'skeleton_attack'
            },
            ['death'] = {
                frames = {1, 2, 3},
                interval = 0.2,
                texture = 'skeleton_death'
            }
        },
        name = 'skeleton',
        speed = 20,
        health = 200,
        agroRange = 6,
        attackRange = 1,
        damage = 15
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
                interval = 0.8,
                texture = 'skeleton-archer_attack'
            },
            ['attack-right'] = {
                frames = {4, 5, 6},
                interval = 0.8,
                texture = 'skeleton-archer_attack'
            },
            ['attack-down-right'] = {
                frames = {7, 8, 9},
                interval = 0.8,
                texture = 'skeleton-archer_attack'
            },
            ['attack-down'] = {
                frames = {10, 11, 12},
                interval = 0.8,
                texture = 'skeleton-archer_attack'
            },
            ['attack-down-left'] = {
                frames = {13, 14, 15},
                interval = 0.8,
                texture = 'skeleton-archer_attack'
            },
            ['attack-left'] = {
                frames = {16, 17, 18},
                interval = 0.8,
                texture = 'skeleton-archer_attack'
            },
            ['attack-up-left'] = {
                frames = {19, 20, 21},
                interval = 0.8,
                texture = 'skeleton-archer_attack'
            },
            ['attack-up'] = {
                frames = {22, 23, 24},                          
                interval = 0.8,
                texture = 'skeleton-archer_attack'
            },
            ['death'] = {
                frames = {1, 2, 3},
                interval = 0.2,
                texture = 'skeleton_death'
            }
        },
        name = 'skeleton-archer',
        speed = 15,
        health = 150,
        agroRange = 8,
        attackRange = 5,
        damage = 25,
        projectileType = 'arrow',
        projectileSpeed = 100,
        attackSpeed = 0.1,
    },
    ['Lich'] = {
        animations = {
            ['walk-up-right'] = {
                frames = {2, 3},
                interval = 0.15,
                texture = 'Lich'
            },
            ['walk-right'] = {
                frames = {5, 6},
                interval = 0.15,
                texture = 'Lich'
            },
            ['walk-down-right'] = {
                frames = {8, 9},
                interval = 0.15,
                texture = 'Lich'
            },
            ['walk-down'] = {
                frames = {11, 12 },
                interval = 0.15,
                texture = 'Lich'
            },
            ['walk-down-left'] = {
                frames = {14, 15},
                interval = 0.15,
                texture = 'Lich'
            },
            ['walk-left'] = {
                frames = {17, 18},
                interval = 0.15,
                texture = 'Lich'
            },
            ['walk-up-left'] = {
                frames = {20, 21},
                interval = 0.15,
                texture = 'Lich'
            },
            ['walk-up'] = {
                frames = {23, 24},                          
                interval = 0.15,
                texture = 'Lich'
            },
            ['idle-up-right'] = {
                frames = {1},
                texture = 'Lich'
            },
            ['idle-right'] = {
                frames = {4},
                texture = 'Lich'
            },
            ['idle-down-right'] = {
                frames = {7},
                texture = 'Lich'
            },
            ['idle-down'] = {
                frames = {10},
                texture = 'Lich'
            },
            ['idle-down-left'] = {
                frames = {13},
                texture = 'Lich'
            },
            ['idle-left'] = {
                frames = {16},
                texture = 'Lich'
            },
            ['idle-up-left'] = {
                frames = {19},
                texture = 'Lich'
            },
            ['idle-up'] = {
                frames = {22},
                texture = 'Lich'
            },
            ['attack-up-right'] = {
                frames = {1, 2, 3},
                interval = 0.4,
                texture = 'Lich_attack'
            },
            ['attack-right'] = {
                frames = {4, 5, 6},
                interval = 0.4,
                texture = 'Lich_attack'
            },
            ['attack-down-right'] = {
                frames = {7, 8, 9},
                interval = 0.4,
                texture = 'Lich_attack'
            },
            ['attack-down'] = {
                frames = {10, 11, 12},
                interval = 0.4,
                texture = 'Lich_attack'
            },
            ['attack-down-left'] = {
                frames = {13, 14, 15},
                interval = 0.4,
                texture = 'Lich_attack'
            },
            ['attack-left'] = {
                frames = {16, 17, 18},
                interval = 0.4,
                texture = 'Lich_attack'
            },
            ['attack-up-left'] = {
                frames = {19, 20, 21},
                interval = 0.4,
                texture = 'Lich_attack'
            },
            ['attack-up'] = {
                frames = {22, 23, 24},                          
                interval = 0.4,
                texture = 'Lich_attack'
            },
            ['death'] = {
                frames = {1, 2, 3},
                interval = 0.2,
                texture = 'Lich_death'
            }
        },
        name = 'Lich',
        speed = 15,
        health = 3000,
        agroRange = 20,
        attackRange = 8,
        damage = 35,
        projectileType = 'fireball',
        projectileSpeed = 70,
        attackSpeed = 0.1,
    }
}