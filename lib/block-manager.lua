local coronalib = require('lib.coronalib')
local display = coronalib('display')
local physics = coronalib('physics')

local BlockManager = {}
function BlockManager:new(o)
  assert(o)
  assert(o.sizeRatio, 'please specify sizeRatio')
  assert(o.deviceWidth, 'please specify deviceWidth')
  assert(o.displayGroup, 'please specify displayGroup')

  setmetatable(o, self)
  self.__index = self
  self._blocks = {}
  return o
end

function BlockManager:add(x, y, w, h, opts)
  x = x * self.sizeRatio
  y = y * self.sizeRatio
  w = w * self.sizeRatio
  h = h * self.sizeRatio
  degrees = opts.degrees or 0

  local image
  if (opts.mirrorX) then
    x = self.deviceWidth - x
    degrees = degrees * (-1)
    image = './img/block-right.png'
  else
    image = './img/block-left.png'
  end

  local block = display.newImageRect(self.displayGroup, image, w, h)
  block.x = x
  block.y = y
  block.anchorX = 0.5
  block.anchorY = 0.5
  if (degrees ~= 0) then block:rotate(degrees) end

  physics.addBody(block, 'static', { 
      box = {
        halfWidth = w / 2,
        halfHeight = h / 4
      },
      friction = 1
    })
  table.insert(self._blocks, block)
  return block
end

function BlockManager:addBlocks(blocks)
  for i = 1, #blocks do
    local block = blocks[i]
    local x, y, w, h, degrees, mirrorX = unpack(block)
    self:add(x, y, w, h, {
      degrees = degrees or 0,
      mirrorX = mirrorX or false
    })
  end
end

function BlockManager:dispose()
  if self._blocks ~= nil then
    for i = 1, #self._blocks do
      self.displayGroup:remove(self._blocks[i])
    end
  end
end

return BlockManager
