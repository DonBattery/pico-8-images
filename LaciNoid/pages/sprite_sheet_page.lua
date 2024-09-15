local sprite_sheet_page = {}

function sprite_sheet_page:enter()

end

function sprite_sheet_page:exit()

end

function sprite_sheet_page:keypressed(key)

end

function sprite_sheet_page:keyreleased(key)

end

function sprite_sheet_page:mousedown(mouse_pos, button)

end

function sprite_sheet_page:mouseup(mouse_pos, button)

end

function sprite_sheet_page:wheelmoved(mouse_pos, dir)

end

function sprite_sheet_page:update(dt, mouse_pos)

end

function sprite_sheet_page:draw()
    draw.rect_fill(v2(50, 0), v2(178, 128), color.green)
    draw.rect(v2(50, 0), v2(178, 128), color.green)
    color.light_green:set()
    love.graphics.print("sprite sheet page", 51, 1)
end

return sprite_sheet_page
