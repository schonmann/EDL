local Utils = {}

function clamp(x,min,max)
    if x > max then
        x = max
    elseif x < min then
        x = min
    end

    return x
end

function distance(x1,y1,x2,y2)
    return math.sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1))
end

function max(a,b)
    return a > b and a or b
end

function min(a,b)
    return a < b and a or b
end

Utils.clamp = clamp
Utils.distance = distance
Utils.max = max
Utils.min = min

return Utils
