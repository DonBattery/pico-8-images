local sprite_page = {}

function sprite_page:enter()

end

function sprite_page:exit()

end

function sprite_page:keypressed(key)

end

function sprite_page:keyreleased(key)

end

function sprite_page:mousedown(mouse_pos, button)

end

function sprite_page:mouseup(mouse_pos, button)

end

function sprite_page:wheelmoved(mouse_pos, dir)

end

function sprite_page:update(dt, mouse_pos)

end

function sprite_page:draw()
    draw.rect_fill(v2(50, 0), v2(178, 128), color.black)
    draw.rect(v2(50, 0), v2(178, 128), color.green)
    color.light_green:set()
    love.graphics.print("sprite page", 51, 1)
end

return sprite_page
