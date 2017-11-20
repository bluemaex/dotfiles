-- logger
hs.logger.defaultLogLevel="debug"
logger = hs.logger.new('maexspoon')

-- Some useful global variables
hyper = {"cmd","alt","ctrl"}
hyper_shift = {"cmd","alt","ctrl","shift"}

-- reload hotkey
hs.hotkey.bind(hyper, "R", function()
  hs.reload()
end)

-- SpoonInstall, to install/load sppons
-- http://www.hammerspoon.org/Spoons/SpoonInstall.htmk
hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true
Install=spoon.SpoonInstall

-- load modules
require "window-grid"
require "window-layout"
require "wifi"
require "wallpaper"

-- print config loaded
hs.notify.show("Loaded Config", "Have fun!", "")
