hs.layout.left85 = {0.0, 0.0, 0.85, 1.0}
hs.layout.right85 = {0.15, 0.0, 0.85, 1.0}
local left85t90 = {0.0, 0.0, 0.90, 0.95}
local left85b90 = {0.0, 0.1, 0.90, 0.95}

local l_screen = hs.screen{x=0,y=0}
local c_screen = hs.screen{x=1,y=0}
local r_screen = hs.screen{x=2,y=0}

local oneScreenLayout = {
  {"Atom",            nil, l_screen, hs.layout.right85, nil, nil},
  {"Firefox",         nil, l_screen, left85t95,         nil, nil},
  {"iTerm2",          nil, l_screen, left85b90,         nil, nil},
}

local twoScreenLayout = {
  {"WebEx",           nil, l_screen, hs.layout.left85,  nil, nil},
  {"Firefox",         nil, c_screen, hs.layout.right85, nil, nil},
  {"Google Chrome",   nil, c_screen, hs.layout.left85,  nil, nil},
  {"iTerm2",          nil, c_screen, hs.layout.right85, nil, nil},
}

local threeScreenLayout = {
  {"Atom",            nil, r_screen, hs.layout.left85,  nil, nil},
  {"Firefox",         nil, l_screen, hs.layout.right85, nil, nil},
  {"Google Chrome",   nil, l_screen, hs.layout.left85,  nil, nil},
  {"iTerm2",          nil, r_screen, hs.layout.right85, nil, nil},
  {"Hipchat",         nil, c_screen, left85t95,         nil, nil},
  {"IRCCloud",        nil, c_screen, left85b90,         nil, nil},
  {"Tweetbot",        nil, c_screen, hs.layout.right25, nil, nil},
}

-- screen watcher, than re-sorts everything when monitors changes
function screenWatcher()
  local numberOfScreens = #hs.screen.allScreens()
  for i = 1, numberOfScreens do
    hs.alert.show(hs.screen.allScreens()[i]:name())
  end

  if numberOfScreens == 1 then
      hs.notify.show("Monitors Changed", "One Monitor", "")
      hs.layout.apply(oneScreenLayout)
  elseif numberOfScreens == 2 then
      hs.notify.show("Monitors Changed", "Dual Monitor, nice", "")
      hs.layout.apply(twoScreenLayout)
  elseif numberOfScreens == 3 then
      hs.notify.show("Monitors Changed", "Triple Monitor, fancy", "")
      hs.layout.apply(threeScreenLayout)
  end
end
hs.hotkey.bind(hyper, 'd', screenWatcher)
-- hs.screen.watcher.new(screenWatcher):start()
