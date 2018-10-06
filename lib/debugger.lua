local os = require('os')

local function debugger()
  print('--- Starting Mob Debugger ---')
  require('mobdebug').start()
end

local DEBUGGER = os.getenv('DEBUGGER') == '1'
if (DEBUGGER) then debugger() end

return debugger
