
-- gfx
dye_math = require "dye:dye/math"
dye_primitives = require "dye:dye/primitives"

-- physx
chipmunk = require "chipmunk:chipmunk/Highlevel"
cpv = chipmunk.CpUtils.cpv

-- ooc sdk
random = require "sdk:math/Random"
Random = random.Random

-- penlight
List = require "pl.List"

class MyBox
  new: (@app, x, y) =>
    mass = 5
    size = dye_math.Vec2.new(32, 32)

    moment = chipmunk.CpUtils.momentForBox(mass, size.x, size.y)
    @body = @app.space\addBody(chipmunk.Body.new(mass, moment))
    @body.pos = cpv(x, y)
    @box = @app.space\addShape(chipmunk.BoxShape.new(@body, size.x, size.y))
    @box.friction = 0.7

    @rect = dye_primitives.GlRectangle.new(size)
    with @rect.color
      .r = math.random(40, (240 * y) % 255)
      .g = math.random(10, 15)
      .b = math.random(30, 35)
    @app.dye\add @rect

  update: =>
    bodyPos = @body.pos
    with @rect.pos
      .x = bodyPos.x
      .y = bodyPos.y
    @rect.angle = @body.angle * 180.0 / 3.14

class App
  new: (@clf) =>
    -- yay
    print "In app.new"
    @dye = @clf.dye
    @space = chipmunk.Space.new()
    @space.gravity = cpv(0, -80)
    @space.iterations = 5

    @dye.currentScene.pos = @dye.center

    -- add ground
    ground = chipmunk.SegmentShape.new(@space.staticBody, cpv(-1000, -260), cpv(1000, -260), 0)
    ground.friction = 0.5
    @space\addShape(ground)

    -- spawn boxes
    @boxes = List()
    side = 36
    for x = -10, 10
      for y = -6, 9
        @boxes\append MyBox(@, x * side, y * side)

  load: =>
    -- muffin to do

  update: =>
    @space\step(0.016)
    @space\step(0.016)
    for box in @boxes\iter!
      box\update!

return { :App }
