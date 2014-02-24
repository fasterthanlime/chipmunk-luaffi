
class App
  new: (@clf) =>
    -- yay
    @dye = @clf.dye

  update: =>
    print "Updating!"

return { :App }
