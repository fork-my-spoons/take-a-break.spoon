# Take a break

A simple menu bar app which sends a notification (or a popup alert) to take a break after a given time:

![menu](./screenshots/menu.png)

Time left in minutes:  
![timer](./screenshots/timer.png)

Alert:  
![alert](./screenshots/alert.png)

Notification:  
![notification](./screenshots/notification.png)

# Installation

 - download and install [Hammerspoon](https://github.com/Hammerspoon/hammerspoon/releases/latest)
 - download and install [Take a break Spoon]()
 - open ~/.hammerspoon/init.lua and add following snippet:

```lua
-- GitLab
-- take a break
hs.loadSpoon("takeABreak")
spoon.takeABreak:setup{notificationType = 'alert'} -- or 'notificaton'
```