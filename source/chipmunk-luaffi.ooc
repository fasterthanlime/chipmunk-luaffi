
use chipmunk
import chipmunk

use dye
import dye/[core, app, math, primitives]

import math/Random
import structs/ArrayList

ChipmunkLuaffi: class extends App {

    space: CpSpace
    boxes := ArrayList<MyBox> new()

    init: func {
        super("Chipmunk LuaFFI test", 1280, 720)
        dye setClearColor(Color black())
    }

    setup: func {
        gravity := cpv(0, -200)

        space = CpSpace new()
        space setGravity(gravity)

        // Add a static line segment shape for the ground.
        // We attach it to space->staticBody to tell Chipmunk it shouldn't be movable.
        ground := CpSegmentShape new(space getStaticBody(), cpv(0, 0), cpv(1280, 0), 0)
        ground setFriction(0.3)
        space addShape(ground)

        baseX := 1280 * 0.5
        baseY := 200

        for (i in 0..15) {
            for (j in -10..10) {
                mybox := MyBox new(this, baseX + j * 45, baseY + i * 45)
                boxes add(mybox)
            }
        }
    }

    update: func {
        space step(1.0 / 60.0)

        for (b in boxes) {
            b update()
        }
    }

}

MyBox: class {
    app: ChipmunkLuaffi
    body: CpBody
    rect: GlRectangle

    init: func (=app, x, y: Float) {
        size := vec2(48, 48)
        pos := vec2(x, y)

        mass := 10
        moment := cpMomentForBox(mass, size x, size y)

        body = app space addBody(CpBody new(mass, moment))
        body setPos(cpv(pos x, pos y))

        box := app space addShape(CpBoxShape new(body, size x, size y))
        box setFriction(0.3)

        rect = GlRectangle new(size)
        rect color r = Random randInt(0, 255)
        rect color g = Random randInt(0, 255)
        rect color b = Random randInt(0, 255)
        rect opacity = 0.4
        app dye add(rect)
    }

    update: func {
        pos := body getPos()
        rect pos x = pos x
        rect pos y = pos y
        rect angle = body getAngle() * 180.0 / 3.14
    }
}

main: func {
    app := ChipmunkLuaffi new()
    app run(60.0)
}

