local util = {}

function clamp(x,min,max)
    if x > max then
        x = max
    elseif x < min then
        x = min
    end

    return x
end

function max(a,b)
    return a > b and a or b
end

function min(a,b)
    return a < b and a or b
end

util.clamp = clamp
util.max = max
util.min = min

return util