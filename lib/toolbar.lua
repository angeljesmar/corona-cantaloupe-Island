local coronalib = require('lib.coronalib')
local widget = coronalib('widget')

local Toolbar = {}
function Toolbar:new(o)
  assert(o)
  assert(o.sizeRatio, 'please specify sizeRatio')
  assert(o.deviceWidth, 'please specify deviceWidth')
  assert(o.deviceHeight, 'please specify deviceHeight')
  assert(o.displayGroup, 'please specify displayGroup')
  assert(o.ongo, 'please specify ongo')

  setmetatable(o, self)
  self.__index = self
  return o
end

function Toolbar:init()
  local buttonHeight = self.deviceHeight / 15 
  local gobutton = widget.newButton({
    width = self.deviceWidth / 5,
    height = buttonHeight,
    fontSize = 48,
    shape = 'roundedRect',
    labelColor = { default = { 1, 1, 1, 1 } },
    fillColor = { default={ 0.2, 0.2, 1, 0.7 }, over={ 1, 0.2, 0.5, 1 } },
    strokeColor = { default={ 0, 0, 0 }, over={ 0.4, 0.1, 0.2 } },
    label = 'GO',
    onRelease = self.ongo
  })
  gobutton.x = display.contentCenterX
  gobutton.y = self.deviceHeight - (buttonHeight / 2)

  self.displayGroup:insert(gobutton)
end

return Toolbar
