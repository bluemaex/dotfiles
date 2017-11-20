----------------------------------------------------------------------
-- http://www.hammerspoon.org/Spoons/WiFiTransitions.html
function reconfigVolume(volume)
  hs.audiodevice.defaultOutputDevice():setVolume(volume)
end

Install:andUse("WiFiTransitions",
  {
    config = {
       actions = {
          -- { -- Test action just to see the SSID transitions
          --    fn = function(_, _, prev_ssid, new_ssid)
          --       hs.notify.show("SSID change", string.format("From '%s' to '%s'", prev_ssid, new_ssid), "")
          --    end
          -- },
          {
            to = "wimaex-fuenf",
            fn = { hs.fnutils.partial(reconfigVolume, 25) }
          },
          {
            from = "wimaex-fuenf",
            fn = { hs.fnutils.partial(reconfigVolume, 0) }
          },
       }
    },
    start = true,
  }
)
