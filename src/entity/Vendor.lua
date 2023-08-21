Vendor = Class{}

function Vendor:init(def)
    self.mapX = def.mapX
    self.mapY = def.mapY
    self.width = def.width 
    self.height = def.height 
    self.salesTable = {}
end