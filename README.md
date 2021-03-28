# Take a break

A simple menu bar app which sends a notification (or a popup alert) to take a break after a given time:

<p align="center">
  <img src="https://github.com/fork-my-spoons/take-a-break.spoon/raw/main/screenshots/menu.png"/>
</p>

Time left in minutes: 
<p align="center">
  <img src="https://github.com/fork-my-spoons/take-a-break.spoon/raw/main/screenshots/timer.png"/>
</p>

Alert: 
<p align="center">
  <img src="https://github.com/fork-my-spoons/take-a-break.spoon/raw/main/screenshots/alert.png"/>
</p>

Notification:  
<p align="center">
  <img src="https://github.com/fork-my-spoons/take-a-break.spoon/raw/main/screenshots/notification.png"/>
</p>

# Installation


- install [Hammerspoon](http://www.hammerspoon.org/) - a powerful automation tool for OS X
   - Manually:

      Download the [latest release](https://github.com/Hammerspoon/hammerspoon/releases/latest), and drag Hammerspoon.app from your Downloads folder to Applications.
   - Homebrew:

      ```brew install hammerspoon --cask```
 - download [github-activity.spoon](https://github.com/fork-my-spoons/take-a-break.spoon/releases/download/v1.0/take-a-break.spoon.zip), unzip and double click on a .spoon file. It will be installed under ~/.hammerspoon/Spoons folder.
 - open ~/.hammerspoon/init.lua and add the following snippet:

```lua
-- take a break
hs.loadSpoon("take-a-break")
spoon['take-a-break']:setup{notificationType = 'alert'}
```

This app uses icons, to properly display them, install a [feather-font](https://github.com/AT-UI/feather-font) by [downloading](https://github.com/AT-UI/feather-font/raw/master/src/fonts/feather.ttf) this .ttf font and installing it.
