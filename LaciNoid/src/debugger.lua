local debugger = {
    lines = {},
    max_lines = 5
}

function debugger:log(message)
    table.insert(self.lines, {
        message = message,
        inserted_at = love.timer.getTime(),
    })
end

function debugger:update(dt)
    local current_time = love.timer.getTime()
    local i = 1
    while i <= #self.lines do
        local line = self.lines[i]
        local age = current_time - line.inserted_at
        if age > 6 then
            table.remove(self.lines, i)
        else
            i = i + 1
        end
    end
end

function debugger:draw_to(pos)
    local current_time = love.timer.getTime()
    local line_height = 6

    -- Calculate the starting y position for the bottom-most message
    local start_y = pos.y + (self.max_lines - 1) * line_height

    -- Determine the range of messages to display
    local start_index = math.max(1, #self.lines - self.max_lines + 1)
    local end_index = #self.lines

    for i = start_index, end_index do
        local line = self.lines[i]
        local age = current_time - line.inserted_at
        local alpha = 1

        if age > 3 then
            alpha = 1 - (age - 3) / 3
        end

        love.graphics.setColor(1, 1, 1, alpha)
        local y_position = start_y - (end_index - i) * line_height
        love.graphics.print(line.message, pos.x, y_position)
    end
end

return debugger
