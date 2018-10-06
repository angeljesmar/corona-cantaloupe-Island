local CORONA = coronabaselib ~= nil

local function coronalib(n)
  if CORONA then
    return require(n)
  else
    return require('test.stubs.' .. n)
  end
end

return coronalib
