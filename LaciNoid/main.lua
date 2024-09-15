-- Import the Love 2D library
_G.love = require("love")

-- Import 3th party libraries
-- Import Push for virtual resolution
_G.push = require("lib.push")
-- Import Brinevector for 2D vector math
_G.v2 = require("lib.brinevector")

-- Import our own modules
-- Import the constant data
_G.debugger = require("src.debugger")
_G.data = require("src.data")
_G.color = require("src.color")
_G.draw = require("src.draw")
_G.collide = require("src.collide")
_G.assets = require("src.assets")
_G.paddle = require("src.paddle")
_G.ball = require("src.ball")

function love.load()
    _G.debug = false
    assets.load_all()
    -- setup Graphics
    love.graphics.setLineWidth(1)
    love.graphics.setLineStyle("rough")
    love.graphics.setDefaultFilter("nearest")
    -- setup Push with the 228*128 virtual resolution based on data screen width and height
    local window_width, window_height = love.graphics.getDimensions()
    push:setupScreen(data.screen.width, data.screen.height, window_width, window_height, {
        fullscreen = false,
        resizable = true,
        highdpi = false,
        canvas = true,
        pixelperfect = false,
    })
    _G.screen_set = true
    -- setup Font
    love.graphics.setFont(assets.fonts.default)

    paddle_width = 5

    balls = {
        ball.new(v2(10, 10), v2(100, 100), 5, color.red),
        ball.new(v2(470, 260), v2(75, -125), 4, color.blue),
        ball.new(v2(440, 145), v2(-100, 100), 3, color.green),
        ball.new(v2(10, 10), v2(100, 100), 5, color.red),
        ball.new(v2(370, 150), v2(12, -12), 4, color.blue),
        ball.new(v2(240, 45), v2(-10, 10), 10, color.green),
        ball.new(v2(120, 120), v2(10, 10), 9, color.red),
        ball.new(v2(170, 360), v2(75, -25), 8, color.blue),
        ball.new(v2(140, 45), v2(-10, 17), 7, color.green),
    }

    paddles = {
        paddle.new(v2(0, data.screen.height - 10), "horizontal", 30, { 0, data.screen.width }, 2),
        paddle.new(v2(0, 5), "horizontal", 60, { 0, data.screen.width / 2 }, 3),
        paddle.new(v2(10, 10), "vertical", 25, { 10, data.screen.height - 10 }, 2),
        paddle.new(v2(300, 10), "vertical", 90, { 40, data.screen.height - 40 }, 7),
    }

    keys = {
        left = false,
        right = false,
        up = false,
        down = false,

        w = false,
        a = false,
        s = false,
        d = false
    }

    players = {
        false,
        false
    }
end

_G.calculateHit = function(ball, paddle, next_pos)
    -- ball: the ball object containing its position (x, y), speed (vx, vy), and max_speed
    -- paddle: the paddle object containing its position (x, y), orientation ('horizontal' or 'vertical'), and size

    if paddle.orientation == 'horizontal' then
        if ball.speed.y > 0 then
            next_pos.y = paddle.pos.y - ball.size
        else
            next_pos.y = paddle.pos.y + ball.size + paddle_width
        end

        local test_point = ball.pos.x
        local paddle_mid = paddle.pos.x + paddle.size / 2
        local x_speed = 0
        if test_point < paddle.pos.x then
            test_point = paddle.pos.x
        elseif test_point > paddle.pos.x + paddle.size - 1 then
            test_point = paddle.pos.x + paddle.size - 1
        end
        if test_point < paddle_mid then
            local diff = paddle_mid - test_point
            x_speed = -((diff / paddle.size) * ball.max_speed)
        elseif test_point > paddle_mid then
            local diff = test_point - paddle_mid
            x_speed = ((diff / paddle.size) * ball.max_speed)
        end
        ball.speed.x = x_speed

        -- Invert the Y speed to bounce back
        ball.speed.y = -ball.speed.y
    elseif paddle.orientation == 'vertical' then
        if ball.speed.x > 0 then
            next_pos.x = paddle.pos.x - ball.size
        else
            next_pos.x = paddle.pos.x + ball.size + paddle_width
        end

        local test_point = ball.pos.y
        local paddle_mid = paddle.pos.y + paddle.size / 2
        local y_speed = 0
        if test_point < paddle.pos.y then
            test_point = paddle.pos.y
        elseif test_point > paddle.pos.y + paddle.size - 1 then
            test_point = paddle.pos.y + paddle.size - 1
        end
        if test_point < paddle_mid then
            local diff = paddle_mid - test_point
            y_speed = -((diff / paddle.size) * ball.max_speed)
        elseif test_point > paddle_mid then
            local diff = test_point - paddle_mid
            y_speed = ((diff / paddle.size) * ball.max_speed)
        end
        ball.speed.y = y_speed

        -- Invert the X speed to bounce back
        ball.speed.x = -ball.speed.x
    end
end

function update_balls(dt)
    for _, ball in ipairs(balls) do
        local next_pos = ball.pos + ball.speed * dt
        local ball_coll = collide.v2circ(next_pos, ball.size)
        local hit = false
        for _, paddle in ipairs(paddles) do
            if paddle.orientation == "horizontal" then
                if collide.rect_vs_circ(collide.v2rect(paddle.pos, v2(paddle.size, paddle_width)), ball_coll) then
                    hit = true
                    calculateHit(ball, paddle, next_pos)
                end
            else
                if collide.rect_vs_circ(collide.v2rect(paddle.pos, v2(paddle_width, paddle.size)), ball_coll) then
                    hit = true
                    calculateHit(ball, paddle, next_pos)
                end
            end
        end
        ball.hit = hit

        if next_pos.x < 0 then
            next_pos.x = 0
            ball.speed.x = -ball.speed.x
        end

        if next_pos.y < 0 then
            next_pos.y = 0
            ball.speed.y = -ball.speed.y
        end

        if next_pos.x > data.screen.width then
            next_pos.x = data.screen.width
            ball.speed.x = -ball.speed.x
        end

        if next_pos.y > data.screen.height then
            next_pos.y = data.screen.height
            ball.speed.y = -ball.speed.y
        end

        ball.pos = next_pos
    end
end

function love.resize(width, height)
    debugger:log("Window resized to width:" .. width .. " height:" .. height)

    push:resize(width, height)
end

function love.keypressed(key)
    debugger:log("Key pressed:" .. key)

    if key == "escape" then
        love.event.quit()
    elseif key == "f1" then
        debug = not debug
    elseif key == "f12" then
        push:switchFullscreen()
    elseif key == "left" then
        keys.left = true
    elseif key == "right" then
        keys.right = true
    elseif key == "up" then
        keys.up = true
    elseif key == "down" then
        keys.down = true
    elseif key == "w" then
        keys.w = true
    elseif key == "a" then
        keys.a = true
    elseif key == "s" then
        keys.s = true
    elseif key == "d" then
        keys.d = true
    end
end

function love.keyreleased(key)
    debugger:log("Key released:" .. key)

    if key == "left" then
        keys.left = false
    elseif key == "right" then
        keys.right = false
    elseif key == "up" then
        keys.up = false
    elseif key == "down" then
        keys.down = false
    elseif key == "w" then
        keys.w = false
    elseif key == "a" then
        keys.a = false
    elseif key == "s" then
        keys.s = false
    elseif key == "d" then
        keys.d = false
    end
end

function love.update(dt)
    update_balls(dt)

    for _, paddle in ipairs(paddles) do
        if (keys.left or keys.right) and paddle.orientation == "horizontal" then
            paddle:move(keys.left and -1 or keys.right and 1)
        end

        if (keys.up or keys.down) and paddle.orientation == "vertical" then
            paddle:move(keys.up and -1 or keys.down and 1)
        end
    end

    if debug then
        debugger:update(dt)
    end
end

function love.draw()
    push:apply("start")

    for _, paddle in ipairs(paddles) do
        paddle:draw()
    end

    for _, ball in ipairs(balls) do
        ball:draw()
    end

    if debug then
        debugger:draw_to(v2(1, 239))
    end

    push:apply("end")
end
