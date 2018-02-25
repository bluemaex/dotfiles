hs.layout.left85 = {0.0, 0.0, 0.85, 1.0}
hs.layout.right85 = {0.15, 0.0, 0.85, 1.0}
local left85t = {0.0, 0.0, 0.90, 0.90}
local left85b = {0.0, 0.1, 0.90, 0.90}

-- screen watcher, than re-sorts everything when monitors changes
function screenWatcher()
  hs.application.enableSpotlightForNameSearches(true)
  local numberOfScreens = #hs.screen.allScreens()
  local screen = hs.screen.allScreens()

  if numberOfScreens == 1 then
      hs.notify.show("Monitors Changed", "One Monitor", "")
      hs.layout.apply({
        {"Atom",            nil, screen[0]:name(), hs.layout.right85, nil, nil},
        {"Firefox",         nil, screen[0]:name(), left85t,         nil, nil},
        {"iTerm2",          nil, screen[0]:name(), left85b,         nil, nil},
      })
  elseif numberOfScreens == 2 then
      hs.notify.show("Monitors Changed", "Dual Monitor, nice", "")
      hs.layout.apply({
        {"WebEx",           nil, screen[0], hs.layout.left85,  nil, nil},
        {"Firefox",         nil, screen[1], hs.layout.right85, nil, nil},
        {"Google Chrome",   nil, screen[1], hs.layout.left85,  nil, nil},
        {"iTerm2",          nil, screen[0], hs.layout.right85, nil, nil},
      })
  elseif numberOfScreens == 3 then
      hs.notify.show("Monitors Changed", "Triple Monitor, fancy", "")
      hs.layout.apply({
        {"Atom",            nil, screen[2], hs.layout.left85,  nil, nil},
        {"iTerm2",          nil, screen[2], hs.layout.right85, nil, nil},
        {"Firefox",         nil, screen[3], hs.layout.right85, nil, nil},
        {"Google Chrome",   nil, screen[3], hs.layout.left85,  nil, nil},
        {"HipChat",         nil, screen[1], left85t,         nil, nil},
        {"IRCCloud",        nil, screen[1], left85b,         nil, nil},
        {"Tweetbot",        nil, screen[1], hs.layout.right50, nil, nil},
      })
  end
end
hs.hotkey.bind(hyper, 'd', screenWatcher)
-- hs.screen.watcher.new(screenWatcher):start()
