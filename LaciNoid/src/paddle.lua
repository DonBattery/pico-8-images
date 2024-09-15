local paddle = {}

function paddle.new(pos, orientation, size, zone, speed)
    local pad = {
        pos = pos,
        orientation = orientation,
        size = size,
        zone = zone,
        speed = speed
    }

    function pad:move(dir)
        if self.orientation == "horizontal" then
            self.pos.x = self.pos.x + dir * self.speed
            if self.pos.x < self.zone[1] then
                self.pos.x = self.zone[1]
            elseif self.pos.x + self.size > self.zone[2] then
                self.pos.x = self.zone[2] - self.size
            end
        else
            self.pos.y = self.pos.y + dir * self.speed
            if self.pos.y < self.zone[1] then
                self.pos.y = self.zone[1]
            elseif self.pos.y + self.size > self.zone[2] then
                self.pos.y = self.zone[2] - self.size
            end
        end
    end

    function pad:draw()
        local pad_size = v2(5, 5)
        local pad_color = color.red

        if self.orientation == "horizontal" then
            pad_size = v2(self.size, 5)
            pad_color = color.blue
            draw.rect_fill(v2(self.zone[1], self.pos.y), v2(math.abs(self.zone[1] - self.zone[2]), 5), color.white)
        else
            pad_size = v2(5, self.size)
            draw.rect_fill(v2(self.pos.x, self.zone[1]), v2(5, math.abs(self.zone[1] - self.zone[2])), color.white)
        end
        draw.rect_fill(self.pos, pad_size, pad_color)
    end

    return pad
end

return paddle
