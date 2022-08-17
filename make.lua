local lm = require "luamake"

lm.mode = "debug"

lm:lua_dll "table_clear" {
    includes = "lua",
    sources = "*.c"
}

--lm:dll "lua54" {
--    defines = "LUA_BUILD_AS_DLL",
--    sources = "lua/onelua.c",
--}
--
--lm:exe "lua" {
--    deps = "lua54",
--    includes = "lua",
--    sources = "lua/lua.c"
--}
