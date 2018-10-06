local sceneName = 'lib.levels.level01'
local coronalib = require('lib.coronalib')

local composer = coronalib('composer')
local display = coronalib('display')
local physics = coronalib('physics')

local scene = composer.newScene()

local Constants = require('lib.constants')
local BlockManager = require('lib.block-manager')
local MelonManager = require('lib.melon-manager')
local Toolbar = require('lib.toolbar')
local BackgroundManager = require('lib.background-manager')

local BG_IMAGE_PATH = 'img/bg.wood.png'

local opts = {
  sizeRatio = Constants.SIZE_RATIO,
  deviceWidth = Constants.WIDTH
}

function scene:_initElements()
  local blockStart = 100
  self._blocks = {
    -- top two
    { 35, blockStart, 105, 45, 30 },
    { 35, blockStart, 105, 45, 30, true },
    -- middle two
    { 50, blockStart + 90, 170, 50, -25 },
    { 50, blockStart + 90, 170, 50, -25, true },
  }

  self._melons = {
    { 5, 1, 100, 0 },
    { 5, 1, 100, 20, true }
  }
  return self
end

function scene:_addBackground()
  self.backgroundManager:addFromImage(BG_IMAGE_PATH)
  return self
end

function scene:_addElements()
  self.blockManager:addBlocks(self._blocks)
  self.melonManager:addMelons(self._melons)
  self.toolbar:init()
  return self
end

function scene:_addToolbar()
  self.toolbar:init()
end

function scene:_ongo()
  -- removeScene only destroys the scene
  -- the first time, resulting in left over melons
  composer.removeScene(sceneName)
  self:dispose()
  composer.gotoScene(sceneName)
end

function scene:_setupScene()
	local sceneGroup = self.view
	composer.removeHidden()

  local backGroup = display.newGroup()
  local toolbarGroup = display.newGroup()
  local blockGroup = display.newGroup()
  local melonGroup = display.newGroup()
  sceneGroup:insert(backGroup)
  sceneGroup:insert(toolbarGroup)
  sceneGroup:insert(blockGroup)
  sceneGroup:insert(melonGroup)

  self.blockManager = BlockManager:new({
    sizeRatio = Constants.SIZE_RATIO,
    deviceWidth = Constants.WIDTH,
    displayGroup = blockGroup
  })
  self.melonManager = MelonManager:new({
    sizeRatio = Constants.SIZE_RATIO,
    deviceWidth = Constants.WIDTH,
    displayGroup = melonGroup
  })

  self.toolbar = Toolbar:new({
    sizeRatio = Constants.SIZE_RATIO,
    deviceHeight = Constants.HEIGHT,
    deviceWidth = Constants.WIDTH,
    displayGroup = melonGroup,
    ongo = function()
      self:_ongo()
    end
  })

  self.backgroundManager = BackgroundManager:new({
    sizeRatio = Constants.SIZE_RATIO,
    deviceWidth = Constants.WIDTH,
    deviceHeight = Constants.HEIGHT,
    displayGroup = toolbarGroup
  })

  self:_initElements()

end
function scene:create(event)
	local sceneGroup = self.view
  print('Creating ' .. sceneName)
  physics.pause()
end

function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase

	if (phase == 'will') then
    print('Will show ' .. sceneName)
    self:_setupScene()
	elseif (phase == 'did') then
    print('Showed ' .. sceneName)

    self
      :_addBackground()
      :_addElements()

    physics.start()
	end
end


function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase

	if (phase == 'will') then
    print('Will hide ' .. sceneName)
	elseif (phase == 'did') then
    print('Hid ' .. sceneName)
    physics.pause()
    composer.removeScene(sceneName)
	end
end


function scene:dispose()
  self.blockManager:dispose()
  self.melonManager:dispose()
end

function scene:destroy(event)
	local sceneGroup = self.view
  print('Destroying ' .. sceneName)
end


scene:addEventListener('create', scene)
scene:addEventListener('show', scene)
scene:addEventListener('hide', scene)
scene:addEventListener('destroy', scene)

physics.start()
physics.setGravity(0, Constants.GRAVITY)

return scene
