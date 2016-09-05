local Utils = {}

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

Utils.clamp = clamp
Utils.max = max
Utils.min = min

return Utils