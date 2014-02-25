
use chipmunk
import chipmunk, chipmunk/Highlevel

use dye
import dye/[core, app, math, primitives]

import math/Random
import structs/ArrayList

// catchall
use deadlogger
import deadlogger/[Log, Logger]

use luajit
import lua/State, lua/howling/Binding

ChipmunkLuaffi: class extends App {

    lua: Binding

    init: func {
        This instance = this
        super("Chipmunk LuaFFI test", 1280, 720)
        dye setClearColor(Color black())
    }

    setup: func {
        "Loading bindings..." println()
        lua = Binding new("./lua_bindings")
        "Running lua file..." println()
        lua runFile("assets/lua/init.lua")
    }

    update: func {
        lua runString("clf_update()")
    }

    // shingleton
    instance: static This

    getInstance: static func -> This {
        instance
    }

}

main: func {
    app := ChipmunkLuaffi new()
    app run(60.0)
}

