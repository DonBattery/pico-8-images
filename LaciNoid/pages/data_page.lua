local data_page = {}

function data_page:enter()

end

function data_page:exit()

end

function data_page:keypressed(key)

end

function data_page:keyreleased(key)

end

function data_page:mousedown(mouse_pos, button)

end

function data_page:mouseup(mouse_pos, button)

end

function data_page:wheelmoved(mouse_pos, dir)

end

function data_page:update(dt, mouse_pos)

end

function data_page:draw()
    draw.rect_fill(v2(50, 0), v2(178, 128), color.black)
    draw.rect(v2(50, 0), v2(178, 128), color.green)
    color.light_green:set()
    love.graphics.print("data page", 51, 1)
end

return data_page
