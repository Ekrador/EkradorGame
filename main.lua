require 'src/Dependencies'

function love.load()
    math.randomseed(os.time())
    love.window.setTitle('Ekrador\'s Game')
    love.graphics.setDefaultFilter('nearest', 'nearest')

    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    gStateStack = StateStack()
    gStateStack:push(StartState())

    love.keyboard.keysPressed = {}
    love.mouse.keysPressed = {}
    love.mouse.keysReleased = {}
    mouseTileX = 0
    mouseTileY = 0
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.mousepressed(x, y, key)
    love.mouse.keysPressed[key] = true
end

function love.mousereleased(x, y, key)
    love.mouse.keysReleased[key] = true 
end

function love.mouse.wasPressed(key)
    return love.mouse.keysPressed[key]
end

function love.mouse.wasReleased(key)
    return love.mouse.keysReleased[key]
end


function love.update(dt)
    mx, my = push:toGame(love.mouse.getPosition())
    mouseInScreenX = mx - VIRTUAL_WIDTH/2 
    mouseInScreenY = my - VIRTUAL_HEIGHT/2 

    Timer.update(dt)
    gStateStack:update(dt)
    
    
    love.mouse.keysPressed = {}
    love.mouse.keysReleased = {}
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    gStateStack:render()
    push:finish()
end


function invert_matrix(a, b, c, d)  
    det = (1 / (a * d - b * c))
    
    return {
      a= det * d,
      b= det * -b,
      c= det * -c,
      d= det * a
    }
end
  
function to_grid_coordinate(x,y) 
    local a = 1 * 0.5 * 32
    local b = -1 * 0.5 * 32
    local c =  0.5 * 16
    local d =  0.5 * 16
    
    inv = invert_matrix(a, b, c, d)
    local invertX
    local invertY
    
    --player.height
    invertX = math.floor(x* inv.a + (y+39)  * inv.b + 1)
    invertY = math.floor(x * inv.c + (y+39) * inv.d + 1)
    
    return invertX, invertY
end

function instanceOf(subject, super)

	super = tostring(super)
	local mt = getmetatable(subject)

	while true do
		if mt == nil then return false end
		if tostring(mt) == super then return true end

		mt = getmetatable(mt)
	end	
end

