NPC = Class{__includes = Entity}

function NPC:init(def)
    Entity.init(self, def)
    self.text = def.text
end

function NPC:onInteract()
    gStateStack:push(DialogueState(self.text))
end