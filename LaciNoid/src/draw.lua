local draw = {}

function draw.px(position, c)
    c = c or color.white
    love.graphics.setColor(c)
    love.graphics.points(position.x, position.y)
end

function draw.rect(position, size, c)
    if size.x < 0.1 or size.y < 0.1 then
        return
    end

    c = c or color.white
    love.graphics.setColor(c)
    love.graphics.rectangle("line", position.x + 0.01, position.y + 0.01, size.x - 0.1, size.y - 0.1)
end

function draw.rect_fill(position, size, c)
    if size.x < 0.1 or size.y < 0.1 then
        return
    end

    c = c or color.white
    love.graphics.setColor(c)
    love.graphics.rectangle("fill", position.x + 0.01, position.y + 0.01, size.x - 0.1, size.y - 0.1)
end

function draw.circ(position, radius, c)
    c = c or color.white
    love.graphics.setColor(c)
    love.graphics.circle("line", position.x, position.y, radius)
end

function draw.circ_fill(position, radius, c)
    c = c or color.white
    love.graphics.setColor(c)
    love.graphics.circle("fill", position.x, position.y, radius)
end

return draw
