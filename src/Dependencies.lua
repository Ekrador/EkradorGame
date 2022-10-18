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
require 'src/states/StartState'
require 'src/states/PlayState'

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
require 'src/states/entity/PlayerAttackState'
require 'src/states/entity/PlayerAbilityState'
require 'src/states/entity/EntityStunnedState'
require 'src/world/tile_ids'
require 'src/world/levels_defs'
require 'src/world/Level'
require 'src/world/Tile'
require 'src/world/TileMap' 

require 'ui/Interface'
require 'ui/Inventory'
require 'ui/TalentTree'


gTextures = {
    ['grass'] = love.graphics.newImage('graphics/grass.png'),
    ['road'] = love.graphics.newImage('graphics/road.png'),
    ['ground'] = love.graphics.newImage('graphics/ground.png'),
    ['tile_road'] = love.graphics.newImage('graphics/tile_road.png'),
    ['player'] = love.graphics.newImage('graphics/player.png'),
    ['skeleton'] = love.graphics.newImage('graphics/skeleton.png'),
    ['wall'] = love.graphics.newImage('graphics/wall.png'),
    ['panel'] = love.graphics.newImage('graphics/panel.png'),
    ['health'] = love.graphics.newImage('graphics/health.png'),
    ['Rage'] = love.graphics.newImage('graphics/rage.png'),
    ['Mana'] = love.graphics.newImage('graphics/mana.png'),
    ['Energy'] = love.graphics.newImage('graphics/energy.png'),
    ['inventory'] = love.graphics.newImage('graphics/inventory.png'),
    ['plus'] = love.graphics.newImage('graphics/plus.png'),
    ['talent_tree'] = love.graphics.newImage('graphics/talent_tree.png'),
    ['warrior_spells'] = love.graphics.newImage('graphics/warrior_spells.png'),
    ['stun'] = love.graphics.newImage('graphics/stun.png')
}

gFrames = {
    ['player'] = GenerateQuads(gTextures['player'], 32, 39),
    ['skeleton'] = GenerateQuads(gTextures['skeleton'], 32, 39),
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
}