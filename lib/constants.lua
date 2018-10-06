local coronalib = require('lib.coronalib')
local display = coronalib('display')

-- no matter what the actual dimensions are we'll address
-- the coordinates as if the width was 300 and the height 1.333 x
-- that (400)
local WIDTH  = display.contentWidth
local HEIGHT = display.contentHeight
local Constants = {
  WIDTH      = WIDTH,
  HEIGHT     = HEIGHT,
  SIZE_RATIO = WIDTH / 300,
  GRAVITY    = 30
}

return Constants
