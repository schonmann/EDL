local renderer = {}

function draw(controller)
    for i,o in pairs(controller.objects) do
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

renderer.draw = draw

return renderer