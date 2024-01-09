GameOverState = Class{__includes = BaseState}
function GameOverState:init(x, y)
    self.x = x
    self.y = y
    gSounds['start_theme']:setVolume(0.3)
    gSounds['start_theme']:setLooping(true)
    gSounds['start_theme']:play()
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gSounds['start_theme']:stop()
        gStateStack:push(FadeInState(self.x, self.y, {
            r = 1, g = 1, b = 1
        }, 2,
        function()
            gStateStack:pop()    
            gStateStack:pop()         
            gStateStack:push(PlayState())          
        end))
    end
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function GameOverState:render()
    love.graphics.setFont(gFonts['gothic-large'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf('GAME OVER', self.x, self.y + VIRTUAL_HEIGHT / 2 - 46, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['gothic-medium'])
    love.graphics.printf('Press Enter for retry or Esc for quit', self.x, self.y + VIRTUAL_HEIGHT / 2 + 14, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['gothic-large'])
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.printf('GAME OVER', self.x, self.y + VIRTUAL_HEIGHT / 2 - 48, VIRTUAL_WIDTH, 'center') 
    love.graphics.setFont(gFonts['gothic-medium'])
    love.graphics.printf('Press Enter for retry or Esc for quit', self.x, self.y + VIRTUAL_HEIGHT / 2 + 16, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gFonts['medium'])
end