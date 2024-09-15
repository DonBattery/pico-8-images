-- Color provides convinient color creating functions and a translation of base palette to English names,
-- so we can refer to  our colors as: color.black
-- Also here we have the list of the player's colors, and helper functions to get them, or set one of them as the drawing color.
local color = {}

-- create a new color from a #hexadecumal string or an "rgb(r,g,b)"" string or and rgba(r,g,b,a) string
function color.new(str, mul)
    mul = mul or 1
    local r, g, b, a
    r, g, b = str:match("#(%x%x)(%x%x)(%x%x)")

    if r then
        r = tonumber(r, 16) / 0xff
        g = tonumber(g, 16) / 0xff
        b = tonumber(b, 16) / 0xff
        a = 1
    elseif str:match("rgba?%s*%([%d%s%.,]+%)") then
        local f = str:gmatch("[%d.]+")
        r = (f() or 0) / 0xff
        g = (f() or 0) / 0xff
        b = (f() or 0) / 0xff
        a = f() or 1
    else
        error(("bad color string '%s'"):format(str))
    end

    local color = { r * mul, g * mul, b * mul, a * mul }
    function color:set()
        love.graphics.setColor(self)
    end

    function color:set_with_alpha(alpha)
        love.graphics.setColor(self[1], self[2], self[3], alpha)
    end

    return color
end

-- Named colors
color.null = color.new("#000000", 0)
color.black = color.new("#000000")
color.red = color.new("#ff0000")
color.blue = color.new("#0000ff")
color.yellow = color.new("#ffff00")
color.white = color.new("#ffffff")
color.green = color.new("#adb834")
color.light_green = color.new("#f8f644")



return color
