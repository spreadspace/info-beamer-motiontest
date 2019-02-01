util.init_hosted()

-- this is only supported on the Raspi....
--util.noglobals()

node.set_flag("no_clear")

gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

local cos = math.cos
local sin = math.sin
local modf = math.modf
local PUSH = gl.pushMatrix
local POP = gl.popMatrix

local TSIZE = 64

local QSIZE = 0.42
local QSPEED = 0.42

local queru = resource.load_image('queru.png')
local font = resource.load_font("ubuntu.ttf")

local function queruPos(t, aspect)
    local dx = sin(QSPEED * t)
    local dy = cos(QSPEED * t)
    local qh = QSIZE/2
    return (dx * aspect) * (1 - (qh/aspect)), dy * (1 - qh)
end

local function drawqueru(now, aspect)
    local x, y = queruPos(now, aspect)
    PUSH()
        gl.translate(x, y)
        gl.translate(QSIZE/-2, QSIZE/-2)
        queru:draw(0, 0, QSIZE, QSIZE)
    POP()
end

local function drawtime(now, size)
   local th, tm, ts, tms
   th, tm = modf((now % 3600)/3600)
   tm, ts = modf(tm*60)
   ts, tms = modf(ts*60)
   tms = tms*1000
   timestr = string.format("%02d:%02d:%02d.%03d", th, tm, ts, tms)
   w = font:width(timestr, size)
   font:write(WIDTH/2 -w/2, HEIGHT/2 - size/2, timestr, size, 1,1,1,1)
end

function node.render()
    aspect = aspect or (WIDTH / HEIGHT)
    local now = sys.now()
    gl.ortho()
    gl.translate(WIDTH/2, HEIGHT/2)
    gl.scale((WIDTH/2) * (1/aspect), HEIGHT/2)
    drawqueru(now, aspect)
    gl.ortho()
    drawtime(now, HEIGHT/10)
end
