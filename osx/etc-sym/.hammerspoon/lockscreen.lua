function lockScreen()
  hs.caffeinate.startScreensaver()
end

hs.hotkey.bind(hyper_shift, 's', lockScreen)
