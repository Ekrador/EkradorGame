Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Animation'
require 'src/StateMachine'
require 'src/Util'
require 'src/const'

require 'src/states/BaseState'
require 'src/states/StateStack'
require 'src/states/game/StartState'
require 'src/states/game/PlayState'
require 'src/states/game/DialogueState'
require 'src/states/game/FadeInState'
require 'src/states/game/FadeOutState'
require 'src/states/game/GameOverState'
require 'src/states/game/VictoryState'


require 'src/entity/entity_defs'
require 'src/entity/entity_spells'
require 'src/entity/Entity'
require 'src/entity/Player'
require 'src/entity/Spells'
require 'src/states/entity/EntityBaseState'
require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityWalkState'
require 'src/states/entity/PlayerIdleState'
require 'src/states/entity/PlayerWalkState'
require 'src/states/entity/EntityAttackState'
require 'src/states/entity/EntityAbilityState'
require 'src/states/entity/PlayerAttackState'
require 'src/states/entity/PlayerAbilityState'
require 'src/states/entity/EntityStunnedState'
require 'src/states/entity/EntityRangedAttackState'
require 'src/states/entity/EntityDeathState'
require 'src/world/tile_ids'
require 'src/world/levels_defs'
require 'src/world/Level'
require 'src/world/Tile'
require 'src/world/TileMap' 
require 'src/world/Items'
require 'src/world/Potions'
require 'src/world/potions_defs'
require 'src/world/items_defs'
require 'src/world/Loot'
require 'src/world/Looting'
require 'src/entity/Vendor'
require 'src/world/Projectile'

require 'ui/Interface'
require 'ui/Inventory'
require 'ui/TalentTree'
require 'ui/ProgressBar'
require 'ui/Trade'
require 'ui/Panel'
require 'ui/Textbox'


gTextures = {
    ['grass'] = love.graphics.newImage('graphics/grass.png'),
    ['road'] = love.graphics.newImage('graphics/road.png'),
    ['ground'] = love.graphics.newImage('graphics/ground.png'),
    ['tile_road'] = love.graphics.newImage('graphics/tile_road.png'),
    ['arrow'] = love.graphics.newImage('graphics/arrow.png'),
    ['fireball'] = love.graphics.newImage('graphics/fireball.png'),
    ['pyroblast'] = love.graphics.newImage('graphics/pyroblast.png'),
    ['fireball_particle'] = love.graphics.newImage('graphics/fireball_particle.png'),
    ['pyroblast_particle'] = love.graphics.newImage('graphics/fireball_particle.png'),
    ['player'] = love.graphics.newImage('graphics/player.png'),
    ['player_attack'] = love.graphics.newImage('graphics/player_attack.png'),
    ['skeleton'] = love.graphics.newImage('graphics/skeleton.png'),
    ['Lich'] = love.graphics.newImage('graphics/Lich.png'),
    ['Lich_attack'] = love.graphics.newImage('graphics/Lich_attack.png'),
    ['skeleton-archer_attack'] = love.graphics.newImage('graphics/skeleton-archer_attack.png'),
    ['skeleton_attack'] = love.graphics.newImage('graphics/skeleton_attack.png'),
    ['skeleton_death'] = love.graphics.newImage('graphics/skeleton_death.png'),
    ['Lich_death'] = love.graphics.newImage('graphics/Lich_death.png'),
    ['wall'] = love.graphics.newImage('graphics/wall.png'),
    ['panel'] = love.graphics.newImage('graphics/panel.png'),
    ['start'] = love.graphics.newImage('graphics/start.png'),
    ['health'] = love.graphics.newImage('graphics/health.png'),
    ['Rage'] = love.graphics.newImage('graphics/rage.png'),
    ['Mana'] = love.graphics.newImage('graphics/mana.png'),
    ['Energy'] = love.graphics.newImage('graphics/energy.png'),
    ['inventory'] = love.graphics.newImage('graphics/inventory.png'),
    ['plus'] = love.graphics.newImage('graphics/plus.png'),
    ['talent_tree'] = love.graphics.newImage('graphics/talent_tree.png'),
    ['warrior_spells'] = love.graphics.newImage('graphics/warrior_spells.png'),
    ['stun'] = love.graphics.newImage('graphics/stun.png'),
    ['chest'] = love.graphics.newImage('graphics/chest.png'),
    ['head'] = love.graphics.newImage('graphics/head.png'),
    ['weapon'] = love.graphics.newImage('graphics/weapon.png'),
    ['shield'] = love.graphics.newImage('graphics/shield.png'),
    ['neck'] = love.graphics.newImage('graphics/neck.png'),
    ['ring'] = love.graphics.newImage('graphics/ring.png'),
    ['boots'] = love.graphics.newImage('graphics/boots.png'),
    ['gloves'] = love.graphics.newImage('graphics/gloves.png'),
    ['legs'] = love.graphics.newImage('graphics/legs.png'),
    ['looting'] = love.graphics.newImage('graphics/looting.png'),
    ['loot'] = love.graphics.newImage('graphics/loot.png'),
    ['vendor'] = love.graphics.newImage('graphics/vendor.png'),
    ['trade'] = love.graphics.newImage('graphics/trade.png'),
    ['gold'] = love.graphics.newImage('graphics/gold.png'),
    ['box'] = love.graphics.newImage('graphics/box.png'),
    ['Health_potion'] = love.graphics.newImage('graphics/Health_potion.png'),
    ['Mana_potion'] = love.graphics.newImage('graphics/Mana_potion.png'),
    ['Energy_potion'] = love.graphics.newImage('graphics/Energy_potion.png'),
    ['Rage_potion'] = love.graphics.newImage('graphics/Rage_potion.png')
}

gFrames = {
    ['player'] = GenerateQuads(gTextures['player'], 32, 39),
    ['player_attack'] = GenerateQuads(gTextures['player_attack'], 32, 39),
    ['skeleton'] = GenerateQuads(gTextures['skeleton'], 32, 39),
    ['Lich'] = GenerateQuads(gTextures['Lich'], 32, 39),
    ['skeleton-archer_attack'] = GenerateQuads(gTextures['skeleton-archer_attack'], 32, 39),
    ['skeleton_attack'] = GenerateQuads(gTextures['skeleton_attack'], 32, 39),
    ['skeleton_death'] = GenerateQuads(gTextures['skeleton_death'], 32, 39),
    ['Lich_death'] = GenerateQuads(gTextures['Lich_death'], 32, 39),
    ['Lich_attack'] = GenerateQuads(gTextures['Lich_attack'], 32, 39),
    ['health'] = GenerateQuads(gTextures['health'], 39, 1),
    ['Rage'] = GenerateQuads(gTextures['Rage'], 39, 1),
    ['Mana'] = GenerateQuads(gTextures['Mana'], 39, 1),
    ['Energy'] = GenerateQuads(gTextures['Energy'], 39, 1),
    ['plus'] = GenerateQuads(gTextures['plus'], 11, 11),
    ['warrior_spells'] = GenerateQuads(gTextures['warrior_spells'], 15, 15)
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['gothic-medium'] = love.graphics.newFont('fonts/GothicPixels.ttf', 16),
    ['gothic-large'] = love.graphics.newFont('fonts/GothicPixels.ttf', 32),
}

gSounds = {
    ['need_space'] = love.audio.newSource('sounds/need_space.wav', 'static'),
    ['need_gold'] = love.audio.newSource('sounds/need_gold.wav', 'static'),
    ['wrong_potion'] = love.audio.newSource('sounds/wrong_potion.wav', 'static'),
    ['coin'] = love.audio.newSource('sounds/coin.wav', 'static'),
    ['item_swap'] = love.audio.newSource('sounds/item_swap.wav', 'static'),
    ['wrong_action'] = love.audio.newSource('sounds/wrong_action.wav', 'static'),
    ['drink'] = love.audio.newSource('sounds/drink.wav', 'static'),
    ['hit'] = love.audio.newSource('sounds/hit.wav', 'static'),
    ['arrow_shot'] = love.audio.newSource('sounds/arrow_shot.wav', 'static'),
    ['arrow_hit'] = love.audio.newSource('sounds/arrow_hit.wav', 'static'),
    ['fireball_shot'] = love.audio.newSource('sounds/fireball_shot.wav', 'static'),
    ['pyroblast_shot'] = love.audio.newSource('sounds/fireball_shot.wav', 'static'),
    ['fireball_hit'] = love.audio.newSource('sounds/fireball_hit.wav', 'static'),
    ['pyroblast_hit'] = love.audio.newSource('sounds/fireball_hit.wav', 'static'),
    ['sword_swing'] = love.audio.newSource('sounds/sword_swing.wav', 'static'), 
    ['step'] = love.audio.newSource('sounds/step.wav', 'static'),
    ['skeletons_step'] = love.audio.newSource('sounds/skeletons_step.wav', 'static'),  
    ['start_theme'] = love.audio.newSource('sounds/start_theme.wav', 'static'), 
    ['game_theme'] = love.audio.newSource('sounds/game_theme.wav', 'static'), 
}