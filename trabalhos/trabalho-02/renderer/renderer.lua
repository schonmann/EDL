local renderer = {}

function draw(o)
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

renderer.draw = draw

return renderer