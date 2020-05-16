aura_env.colorcode = function(name)
    local length = string.len(name)
    if string.sub(name, 2, 3) == "|c" then
        if string.sub(name, length-1) == "|r" then
            return string.sub(name, 12, length-3)
        else
            return string.sub(name, 12)
        end
    elseif string.sub(name, length-1) == "|r" then
        return string.sub(name, 1, length-3)
    else
        return name
    end
end