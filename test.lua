local table_clear = require "table_clear"

local function CLEAR(t)
    local mt = getmetatable(t)
    table_clear(t)
    assert(next(t) == nil)
    assert(getmetatable(t) == mt)
end

CLEAR {}
CLEAR {1,2,3,a=1,b=2,c=3}

local cache = setmetatable({}, {__mode="k"})

local function create_gcobj()
    local o = {}
    cache[o] = true
    return o
end

local function check_gcobj()
    assert(next(cache) == nil)
end

local function TEST(f)
    local t = {}
    f(t)
    CLEAR(t)
    collectgarbage "collect"
    collectgarbage "collect"
    check_gcobj()
end

TEST(function(t)
    t[create_gcobj()] = true
    t.a = create_gcobj()
    t[1] = create_gcobj()
    t[2] = create_gcobj()
end)

TEST(function(t)
    setmetatable(t, {})
end)


print "ok"
