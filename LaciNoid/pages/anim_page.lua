local anim_page = {}

function anim_page:enter()

end

function anim_page:exit()

end

function anim_page:keypressed(key)

end

function anim_page:keyreleased(key)

end

function anim_page:mousedown(mouse_pos, button)

end

function anim_page:mouseup(mouse_pos, button)

end

function anim_page:wheelmoved(mouse_pos, dir)

end

function anim_page:update(dt, mouse_pos)

end

function anim_page:draw()
    draw.rect_fill(v2(50, 0), v2(178, 128), color.black)
    draw.rect(v2(50, 0), v2(178, 128), color.green)
    color.light_green:set()
    love.graphics.print("anim page", 51, 1)
end

return anim_page
