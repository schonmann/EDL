local renderer = {}

function draw(o)
    love.graphics.draw(
        o.image, 
        o.x, 
        o.y, 
        o.r,
        o.sx,
        o.sy)
end

renderer.draw = draw

return renderer