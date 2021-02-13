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

function obj:notifyIn(mins)
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

    obj.refreshTimer = hs.timer.doEvery(60, function() 
        if obj.timer ~= nil and obj.timer:running() then 
            if obj.timer:nextTrigger() < 0 then 
                obj.timer = nil 
                obj.refreshTimer = nil
                obj.indicator:setTitle(nil)
            else
                obj.indicator:setTitle(math.ceil((obj.timer:nextTrigger()/60)))
            end
        end 
    end)
end

function obj:buildMenu()
    local menu = {
        {title = 'Take a break in:', disabled = true},
        {image = hs.image.imageFromPath(obj.iconPath .. '/15m.png'):setSize({w=20,h=20}):template(true), title = '15 minutes', fn = function() obj:notifyIn(15) end},
        {image = hs.image.imageFromPath(obj.iconPath .. '/30m.png'):setSize({w=20,h=20}):template(true), title = '30 minutes', fn = function() obj:notifyIn(30) end},
        {image = hs.image.imageFromPath(obj.iconPath .. '/45m.png'):setSize({w=20,h=20}):template(true), title = '45 minutes', fn = function() obj:notifyIn(45) end},
        {title = '-'}
    }

    if obj.timer ~= nil then
        table.insert(menu, {title = 'Cancel', fn = function() 
            obj.timer = nil 
            obj.refreshTimer = nil
            obj.indicator:setTitle(nil)
        end})
    end
    
    return menu
end

function obj:init()
    self.indicator = hs.menubar.new()
    self.indicator:setIcon(hs.image.imageFromPath(self.iconPath .. '/coffee-cup.png'):setSize({w=16,h=16}), true)

    self.indicator:setMenu(self.buildMenu)
end

function obj:setup(args)
    self.notificationType = args.notificationType or 'alert'
end

return obj