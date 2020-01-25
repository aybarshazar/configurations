-- Map this combination to a key with Karabiner-Elements
-- Check out karabiner.json
local hyper = { "cmd", "alt", "ctrl", "shift" }

-----------------------------------------------
-- https://www.hammerspoon.org/Spoons/ReloadConfiguration.html
-----------------------------------------------

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

-----------------------------------------------
-- Hyper i to show window hints
-----------------------------------------------

hs.hints.showTitleThresh = 10
hs.hints.hintChars = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '0' }

hs.hotkey.bind(hyper, "i", function()
  hs.hints.windowHints()
end)

-----------------------------------------------
-- miro window manager config
-- https://github.com/miromannino/miro-windows-manager
-----------------------------------------------

hs.loadSpoon("MiroWindowsManager")

hs.window.animationDuration = 0
spoon.MiroWindowsManager:bindHotkeys({
  up = {hyper, "up"},
  right = {hyper, "right"},
  down = {hyper, "down"},
  left = {hyper, "left"},
  fullscreen = {hyper, "f"}
})

-----------------------------------------------
-- Applications
-- https://github.com/kozko2001/hammerspoon/blob/master/init.lua#L120-L133
-----------------------------------------------

local apps = {
  c = 'Google Chrome',
  a = 'Atom',
  s = 'Sublime Text',
  t = 'iTerm'
}

for key, app in pairs(apps) do
  hs.hotkey.bind(hyper, key, function()
    local application = hs.application.find(app)

    if not application then
      -- no running app found, launch it
      hs.application.launchOrFocus(app)
      return
    end

    if not application:isFrontmost() then
      -- app is not currently active, focus on it
      hs.application.launchOrFocus(app)
      return
    end

    local windows = application:allWindows()
    local numOfWindows = #windows

    if numOfWindows == 1 then
      -- no-op, there is a single window and it is already focused
      return
    end

    -- select the last window among app windows
    -- this is a simple way to cycle among windows of the app
    -- (lua array indeces start at 1 by default)
    local nextWindow = windows[numOfWindows]
    nextWindow:focus()
  end)
end

-----------------------------------------------
-- Debugging / logging utils
-----------------------------------------------

-- print('--------------------------------------')
-- for i,v in ipairs(windows) do print(i, v) end
-- print('--------------------------------------')

-- local log = hs.logger.new('mymodule','debug')
-- log.i('Initializing')
-- log.i(hs.inspect(apps))
-- log.i(hs.inspect(#apps))
