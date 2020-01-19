-- Map this combination to a key with Karabiner-Elements
local hyper = { "cmd", "alt", "ctrl", "shift" }

-----------------------------------------------
-- https://www.hammerspoon.org/Spoons/ReloadConfiguration.html
-----------------------------------------------

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

-----------------------------------------------
-- Hyper i to show window hints
-----------------------------------------------

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
  hs.hotkey.bind(hyper, key, function() hs.application.launchOrFocus(app) end)
end
