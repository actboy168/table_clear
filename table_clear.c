#include <lua.h>
#include <lauxlib.h>
#include <lstate.h>
#include <lobject.h>

#define swap(TYPE, A, B) do { TYPE tmp = A; A = B; B = tmp; } while (0)

static int table_clear(lua_State* L) {
    luaL_checktype(L, 1, LUA_TTABLE);
    lua_createtable(L, 0, 0);
    Table* a = gco2t(lua_topointer(L, 1));
    Table* b = gco2t(lua_topointer(L, -1));

    //do not swap metatable
    swap(lu_byte, a->flags, b->flags);
    swap(lu_byte, a->lsizenode, b->lsizenode);
    swap(unsigned int, a->alimit, b->alimit);
    swap(TValue*, a->array, b->array);
    swap(Node*, a->node, b->node);
    swap(Node*, a->lastfree, b->lastfree);
    //TODO: call luaC_barrierback_?
    return 0;
}

int luaopen_table_clear(lua_State* L) {
    lua_pushcfunction(L, table_clear);
    return 1;
}
