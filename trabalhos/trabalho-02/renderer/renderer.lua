local renderer = {}

function draw(controller)
    for i,o in pairs(controller.objects) do
        if o.quad ~= nil then
            love.graphics.draw(
                o.image,
                o.quad,
                o.x,
                o.y,
                o.r,
                o.sx,
                o.sy,
                o.w/2,
                o.h/2)
        else
            love.graphics.draw(
                o.image, 
                o.x, 
                o.y, 
                o.r,
                o.sx,
                o.sy,
                o.w/2,
                o.h/2)
        end
    end
end

renderer.draw = draw

return renderer