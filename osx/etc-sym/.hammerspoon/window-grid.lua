-- grid settings
hs.grid.GRIDWIDTH  = 8
hs.grid.GRIDHEIGHT = 4
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0
hs.grid.ui.textSize = 150

-- helper function to set current focused window to a specific size
local gridset = function(frame)
  return function()
    local win = hs.window.focusedWindow()
    if win then
      hs.grid.set(win, frame, win:screen())
    else
      hs.alert.show("No focused window.")
    end
  end
end

-- show the grid layout to resize
hs.hotkey.bind(hyper, 'g', hs.grid.toggleShow)

-- full screen window (but not macos fullscreen)
hs.hotkey.bind(hyper, 'f', hs.grid.maximizeWindow)

-- halfes of the screen
local gw = hs.grid.GRIDWIDTH
local gh = hs.grid.GRIDHEIGHT
hs.hotkey.bind(hyper, 'Left', gridset({x = 0, y = 0, w = gw/2, h = gh}))
hs.hotkey.bind(hyper, 'Right', gridset({x = gw/2, y = 0, w = gw/2, h = gh}))
hs.hotkey.bind(hyper, 'Up', gridset({x = 0, y = 0, w = gw, h = gh/2}))
hs.hotkey.bind(hyper, 'Down', gridset({x = 0, y = 0, w = gw, h = gh/2}))

-- move window position inside the grid
hs.hotkey.bind(hyper_shift, 'Left', hs.grid.pushWindowLeft)
hs.hotkey.bind(hyper_shift, 'Right', hs.grid.pushWindowRight)
hs.hotkey.bind(hyper_shift, 'Up', hs.grid.pushWindowUp)
hs.hotkey.bind(hyper_shift, 'Down', hs.grid.pushWindowDown)

-- snap window to grid
hs.hotkey.bind(hyper, 's', function()
  hs.grid.snap(hs.window.focusedWindow())
end)

-- move between monitors
hs.hotkey.bind(hyper, 'm', function()
  local win = hs.window.focusedWindow()
  local nextScreen = win:screen():previous()
  win:moveToScreen(nextScreen)
end)
