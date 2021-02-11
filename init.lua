local obj = {}
obj.__index = obj

-- Metadata
obj.name = "Take a break"
obj.version = "1.0"
obj.author = "Pavel Makhov"
obj.homepage = "https://github.com/streetturtle/spoonify"
obj.license = "MIT - https://opensource.org/licenses/MIT"

obj.indicator = nil
obj.iconPath = hs.spoons.resourcePath("icons")
obj.timer = nil
obj.refreshTimer = nil
obj.notificationType = nil

local function showAlert()
    hs.alert.show("It's time to take a break!", {
        fillColor = {hex = '#E5E9F0'},
        textColor = {hex = '#3B4252'},
        radius = 8,
        fadeInDuration = 0.5,
        fadeOutDuration = 0.5
    })
end

local function notifyIn(mins)
    obj.indicator:setTitle(mins)
    obj.timer = hs.timer.doAfter(mins * 60, function() 
        if obj.notificationType == 'alert' then
            showAlert() 
        else
            hs.notify.new(function() end,
            {
                autoWithdraw = true,
                title = "Take A Break",
                informativeText = "It's time to take a break!",
                hasActionButton = false,
                contentImage = hs.image.imageFromPath(obj.iconPath .. '/coffee-cup.png')
            }):send()
        end

        obj.indicator:setTitle(nil)
        obj.timer = nil
    end)

    obj.refreshTimer = hs.timer.doEvery(2, function() 
        if obj.timer ~= nil and obj.timer:running() then 
            obj.indicator:setTitle(math.floor(obj.timer:nextTrigger()/60 + 0.5)) 
        end 
    end)
end

function obj:init()
    self.indicator = hs.menubar.new()
    self.indicator:setIcon(hs.image.imageFromPath(obj.iconPath .. '/coffee-cup.png'):setSize({w=16,h=16}), true)

    local menu = {
        {title = 'Take a break in:', disabled = true},
        {title = '15 minutes', fn = function() notifyIn(15) end},
        {title = '30 minutes', fn = function() notifyIn(30) end},
        {title = '45 minutes', fn = function() notifyIn(45) end},
        {title = '-'},
        {title = 'Cancel', fn = function() 
            self.timer = nil 
            self.refreshTimer = nil
            self.indicator:setTitle(nil)
        end},
    }

    obj.indicator:setMenu(menu)

end

function obj:setup(args)
    obj.notificationType = args.notificationType or 'alert'
end

return obj