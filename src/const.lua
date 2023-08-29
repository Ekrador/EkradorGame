VIRTUAL_WIDTH = 384
VIRTUAL_HEIGHT = 216

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

GROUND_WIDTH = 32
GROUND_HEIGHT = 16

BONUS_POINTS_LVLUP = 3
TALENT_POINTS_LVLUP = 1
STASH_LIMIT = 56
STASH_FIRST_ITEM_X = 202
STASH_FIRST_ITEM_Y = 26
STASH_ITEMS_PER_ROW = 8
ITEMS_INDENT = 16
LOOT_LIMIT = 9
LOOT_ITEMS_PER_ROW = 3
LOOT_FIRST_ITEM_X = 57
LOOT_FIRST_ITEM_Y = 51
TRADE_FIRST_ITEM_X = 31
TRADE_FIRST_ITEM_Y = 26

MDx = {0,1,1,1,0,-1,-1,-1}
MDy = {-1,-1,0,1,1,1,0,-1}

function coinSound()
    gSounds['coin']:stop()
    gSounds['coin']:play() 
end

function itemSwapSound()
    gSounds['item_swap']:stop()
    gSounds['item_swap']:play() 
end