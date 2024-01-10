GetInvWeight = function(inv)
    local weight = 0
    for _,v in pairs(inv) do
        local ItemWeight = GetItemWeight(v.name, v.count)
        weight = weight + ItemWeight
    end
    return weight
end

GetItemWeight = function(item, count)
    for _,v in pairs(items) do
        if item == v.name then
            return v.weight * count, v.label
        end
    end
end