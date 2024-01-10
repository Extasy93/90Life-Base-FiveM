cfg_hotel = {
    name = "Vice-Hotel",
    position = vector3(3687.48, 5581.81, 10.02),
    PrixParJour = 150,
    safeMaxQty = 10,
    animationGod = true,

    indoorPosition = vector3(3675.723, 6343.543, 13.79786), 
    heading = 27.32140731811523,
    safePosition = vector3(3672.888, 6349.509, 13.79787),
}

countTable = function(table)
    local i = 0
    for _,_ in pairs(table) do
        i = i + 1
    end
    return i
end

countItems = function(content)
    local i = 0
    for item, qty in pairs(content) do
        i = i + qty
    end
    return i
end