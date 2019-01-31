util.init_hosted()

-- this is only supported on the Raspi....
--util.noglobals()

node.set_flag("no_clear")

gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

local cos = math.cos
local sin = math.sin
local PUSH = gl.pushMatrix
local POP = gl.popMatrix

local QSIZE = 0.16
local QMOVESCALE = 0.42
local QSPEED=0.5

queru = resource.load_image('queru.png')

local function queruPos(t, aspect)
    local dx = aspect*sin(QSPEED * t)
    local dy = cos(QSPEED * t)
    return QMOVESCALE * (1 + (QSIZE/2)) * dx, QMOVESCALE * dy
end

local function drawqueru(now, aspect)
    local x, y = queruPos(now, aspect)
    PUSH()
        gl.translate(x, y)
        gl.translate(QSIZE/-2, QSIZE/-2)
        queru:draw(0, 0, QSIZE, QSIZE)
    POP()
end

function node.render()
    aspect = aspect or (WIDTH / HEIGHT)
    local now = sys.now()

    gl.ortho()
    gl.translate(WIDTH/2, HEIGHT/2)
    gl.scale(WIDTH * (1/aspect), HEIGHT)
    drawqueru(now, aspect)
end
