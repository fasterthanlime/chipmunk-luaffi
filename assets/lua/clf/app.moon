
class App
  new: (@clf) =>
    -- yay
    print "In app.new"
    @dye = @clf.dye

  load: =>
    -- muffin to do

  update: =>
    print "Updating!"

return { :App }
