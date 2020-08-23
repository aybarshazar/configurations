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
  ['1'] = 'Google Chrome',
  ['2'] = 'Sublime Text',
  ['3'] = 'iTerm',
  ['4'] = 'SourceTree',
  ['5'] = 'Slack',
  ['6'] = 'Spotify'
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
-- Focus / break timer

-- Displays iteration and break countdowns in the menu bar
-- The timer can be started (or stopped) by clicking the menu bar widget
-- 5 iterations of 6 minutes = 30 minutes
-- Short breaks of 15 seconds between each iteration
-- A long break of 5 minutes at the end of all iterations
-----------------------------------------------

ITERATION_COUNT = 6
ITERATION_DURATION = 5 * 60 -- 5 minutes
SHORT_BREAK_DURATION = 15 -- 15 seconds
LONG_BREAK_DURATION = 5 * 60 -- 5 minutes

local canvas = require("hs.canvas")
local timer
local menubar
local isIdle, isInIteration, isInLongBreak
local iterationCount, iterationDuration, shortBreakDuration, longBreakDuration

function makeCircleImage(fillColor)
  local imageHolder = canvas.new({ x = 500, y = 500, h = 16, w = 16 })
  imageHolder[1] = {
    action = "fill",
    fillColor = fillColor,
    type = "circle",
  }
  local circle = imageHolder:imageFromCanvas()
  imageHolder:delete()
  return circle
end

local greenCircle = makeCircleImage({ alpha = 0.7, green = 1.0  })
local yellowCircle = makeCircleImage({ alpha = 0.7, red = 1, green = 1, blue = 0 })
local redCircle = makeCircleImage({ alpha = 0.7, red = 1.0 })

function update()
  if isInLongBreak then
    local text = os.date("%M:%S", longBreakDuration)
    menubar:setTitle(text)
    menubar:setIcon(redCircle, false)

    longBreakDuration = longBreakDuration - 1

    if longBreakDuration == -1 then
      reset()
    end
  elseif isInIteration then
    local text = os.date("%M:%S", iterationDuration)
    menubar:setIcon(greenCircle, false)
    menubar:setTitle(text)

    iterationDuration = iterationDuration - 1

    if iterationDuration == -1 then
      isInIteration = false
      iterationDuration = ITERATION_DURATION
      iterationCount = iterationCount - 1

      if iterationCount == 0 then
        isInLongBreak = true
        hs.alert.show("Long break")
      else
        hs.alert.show("Short break")
      end
    end
  else
    local text = os.date("%M:%S", shortBreakDuration)
    menubar:setTitle(text)
    menubar:setIcon(yellowCircle, false)

    shortBreakDuration = shortBreakDuration - 1

    if shortBreakDuration == -1 then
      isInIteration = true
      shortBreakDuration = SHORT_BREAK_DURATION
    end
  end
end

function start()
  isIdle = false

  timer:start()
end

function reset()
  isIdle = true
  isInIteration = true
  isInLongBreak = false

  iterationCount = ITERATION_COUNT
  iterationDuration = ITERATION_DURATION
  shortBreakDuration = SHORT_BREAK_DURATION
  longBreakDuration = LONG_BREAK_DURATION

  timer:stop()

  menubar:setTitle("Start")
  menubar:setIcon()
end

function toggle()
  if isIdle then
    start()
  else
    reset()
  end
end

timer = hs.timer.new(1, update)

menubar = hs.menubar.new()
menubar:setClickCallback(toggle)

reset()

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
