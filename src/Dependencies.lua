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
require 'src/entity/Entity'
require 'src/entity/Player'
require 'src/states/entity/EntityBaseState'
require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityWalkState'
require 'src/states/entity/PlayerIdleState'
require 'src/states/entity/PlayerWalkState'
require 'src/states/entity/EntityAttackState'
require 'src/states/entity/PlayerAttackState'
require 'src/world/tile_ids'
require 'src/world/levels_defs'
require 'src/world/Level'
require 'src/world/Tile'
require 'src/world/TileMap' 

require 'ui/Interface'


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
    ['rage'] = love.graphics.newImage('graphics/rage.png'),
    ['mana'] = love.graphics.newImage('graphics/mana.png'),
    ['energy'] = love.graphics.newImage('graphics/energy.png')
}

gFrames = {
    ['player'] = GenerateQuads(gTextures['player'], 32, 39),
    ['skeleton'] = GenerateQuads(gTextures['skeleton'], 32, 39),
    ['health'] = GenerateQuads(gTextures['health'], 39, 1),'
    ['rage'] = GenerateQuads(gTextures['rage'], 39, 1),
    ['mana'] = GenerateQuads(gTextures['mana'], 39, 1),
    ['energy'] = GenerateQuads(gTextures['energy'], 39, 1)
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