local coronalib = require('lib.coronalib')

local composer = coronalib('composer')
local display = coronalib('display')
local physics = coronalib('physics')

local scene = composer.newScene()

local Constants = require('lib.constants')
local BlockManager = require('lib.block-manager')
local MelonManager = require('lib.melon-manager')

local opts = {
  sizeRatio = Constants.SIZE_RATIO,
  deviceWidth = Constants.WIDTH
}

function scene:create(event)
	local sceneGroup = self.view

end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == 'will' ) then

	elseif ( phase == 'did' ) then

	end
end


function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == 'will' ) then

	elseif ( phase == 'did' ) then

	end
end


function scene:destroy( event )
	local sceneGroup = self.view

end

scene:addEventListener('create', scene)
scene:addEventListener('show', scene)
scene:addEventListener('hide', scene)
scene:addEventListener('destroy', scene)

return scene
