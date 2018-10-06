local coronalib = require('lib.coronalib')
local display = coronalib('display')
local physics = coronalib('physics')

local MelonManager = {}
function MelonManager:new(o)
  assert(o)
  assert(o.sizeRatio, 'please specify sizeRatio')
  assert(o.deviceWidth, 'please specify deviceWidth')
  assert(o.displayGroup, 'please specify displayGroup')

  setmetatable(o, self)
  self.__index = self
  self.displayGroup = o.displayGroup or display.newGroup()
  self._melons = {}
  return o
end

function MelonManager:add(x, y, size, opts)
  size = size or 100
  x = x * self.sizeRatio
  y = y * self.sizeRatio

  if (opts.mirrorX) then
    x = self.deviceWidth - x
  end

  local image = './img/melon.png'
  local melon = display.newImageRect(self.displayGroup, image, size, size)

  melon.x = x
  melon.y = y
  melon.anchorX = 0.5
  melon.anchorY = 0.5

  physics.addBody(melon, 'dynamic', {
    radius = size / 2,
    bounce = 0.5,
    friction = 0.3,
    density = 10
  })

  table.insert(self._melons, melon)
  return melon
end

function MelonManager:addMelons(melons)
  for i = 1, #melons do
    local melon = melons[i]
    local x, y, size, degrees, mirrorX = unpack(melon)
    self:add(x, y, size, {
      degrees = degrees or 0,
      mirrorX = mirrorX or false
    })
  end
end

function MelonManager:dispose()
  if self._melons ~= nil then
    for i = 1, #self._melons do
      self.displayGroup:remove(self._melons[i])
    end
  end
end

return MelonManager
