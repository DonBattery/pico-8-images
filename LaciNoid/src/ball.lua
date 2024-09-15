local ball = {}

function ball.new(pos, speed, size, color)
    local b = {
        pos = pos,
        speed = speed,
        size = size,
        color = color,
        hit = false,
        max_speed = 200
    }

    function b:draw()
        local c = self.color
        if self.hit then c = color.red end
        draw.circ_fill(self.pos, self.size, c)
    end

    return b
end

return ball
