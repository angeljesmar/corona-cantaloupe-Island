require('lib.debugger')
local coronalib = require('lib.coronalib')
local display = coronalib('display')
local physics = coronalib('physics')
local composer = coronalib('composer')

local Constants = require('lib.constants')

-- physics.setDrawMode('hybrid')

local function onaccelerate(event)
  physics.setGravity(event.xRaw * Constants.GRAVITY, Constants.GRAVITY)
end

Runtime:addEventListener('accelerometer', onaccelerate)
composer.gotoScene('lib.levels.level01')
