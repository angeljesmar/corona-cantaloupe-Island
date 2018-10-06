local BackgroundManager = {}
function BackgroundManager:new(o)
  assert(o)
  assert(o.sizeRatio, 'please specify sizeRatio')
  assert(o.deviceWidth, 'please specify deviceWidth')
  assert(o.deviceHeight, 'please specify deviceHeight')
  assert(o.displayGroup, 'please specify displayGroup')

  setmetatable(o, self)
  self.__index = self
  return o
end

function BackgroundManager:addFromImage(imgPath)
  local background = display.newImageRect(
    self.displayGroup,
    imgPath,
    self.deviceWidth,
    self.deviceHeight * 1.4
  )
  background.x = display.contentCenterX
  background.y = display.contentCenterY
end

return BackgroundManager
