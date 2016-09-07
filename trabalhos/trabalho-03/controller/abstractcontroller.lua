local function AbstractController(manager)

    if manager == nil then 
        print("Controller without parent manager. Check your code.")
        return 
    end

    local self = {}
    
    -- Fields.

    self.manager = manager
    self.objects = {}

    -- Methods.
    
    function self.update(dt)
        for i,o in pairs(self.objects) do
            o.update(dt)
        end
    end

    function self.draw()
        for i,o in pairs(self.objects) do
            o.draw()
        end
    end

    function self.init()
        for i,o in pairs(self.objects) do
            o.init()
        end
    end

    function self.handleInput(dt)
        for i,o in pairs(self.objects) do
            o.handleInput(dt)
        end
    end
    
    return self
end

return AbstractController
