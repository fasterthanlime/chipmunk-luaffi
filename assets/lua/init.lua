
-- fix that library stuff
local ffi = require 'ffi'
print("ffi.os = " .. ffi.os)
print("ffi.arch = " .. ffi.arch)

local luaprefix = "./luaprefix"
local luaext = "so"
if ffi.os == "Windows" then
  luaext = "dll"
elseif ffi.os == "OSX" then
  luaext = "dylib"
end

package.path = package.path .. ";assets/lua/?.lua"
package.path = package.path .. ";" .. luaprefix .. "/share/lua/5.1/?/init.lua;" .. luaprefix .. "/share/lua/5.1/?.lua"
package.cpath = package.cpath .. ";" .. luaprefix .. "/lib/lua/5.1/?." .. luaext

-- moon > coffee
print "Loading moonscript"
require('moonscript')

-- penlight for fun and fame
print "Loading penlight"
stringx = require('pl.stringx')
stringx.import() -- add to standard string prototype

-- where it all begins
print "Loading app"
local app = require('clf.app')

-- global state is fun, right?
print "Requiring app"
local clf = require('chipmunk-luaffi:chipmunk-luaffi').ChipmunkLuaffi.getInstance()
print "Requiring logger"
local logger = require('deadlogger:deadlogger/Log').Log.getLogger('Lua')

print "Swapping print"
print = function (msg)
  logger:info(msg)
end

print "Instanciating app"
local app = app.App(clf)

-- global namespace, because that's fun.
print "Setting up global namespace"
Clf = {
  app = app
}

-- now we can load more stuff.
app:load()

function clf_update()
    app:update()
end

