StartState = Class{__includes = BaseState}

function StartState:init()
    gSounds['start_theme']:setVolume(0.3)
    gSounds['start_theme']:setLooping(true)
    gSounds['start_theme']:play()
end

function StartState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateStack:push(FadeInState(0, 0, {
            r = 1, g = 1, b = 1
        }, 1,
        function()
            gSounds['start_theme']:stop()

            gStateStack:pop()
            
            gStateStack:push(PlayState())
            gStateStack:push(DialogueState("" .. 
                "Welcome! Here's a quick guide to the controls...\n" ..
                "Q, W, E, R for skills and 1, 2, 3, 4 for potions on belt slots.\n" ..
                "Press C to open inventory, V to open talent tree.\n" ..
                "RMB - move, Shift - attack.\n" ..
                "There is also a vendor here who sells potions and undefined items.\n" ..
                "He`s assortment updates each few minutes"
            ))
            gStateStack:push(FadeOutState({
                r = 1, g = 1, b = 1
            }, 1,
            function() end))
        end))
    end
end

function StartState:render()
    love.graphics.draw(gTextures['start'], 0, 0)
    love.graphics.setColor(24/255, 24/255, 24/255, 1)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Ekrador`s game', 0, VIRTUAL_HEIGHT / 2 - 72, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 68, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])

end