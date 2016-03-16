# Method to call a robot to go into a direction
goDirection = (direction, element=null, highlight=true) ->
  robot_id = $('#controls').data('robot-id')
  if highlight
    $(element).addClass('highlight')
  else
    $(element).removeClass('highlight')
  $.ajax
    method: "get"
    url: "/#{robot_id}/#{direction}"

# Mouse clicks on buttons
$ -> $('#forward').on 'vmousedown', -> goDirection("forward", this)
$ -> $('#forward').on 'vmouseup', -> goDirection("stop", this, false)
$ -> $('#back').on 'vmousedown', -> goDirection("back", this)
$ -> $('#back').on 'vmouseup', -> goDirection("stop", this, false)
$ -> $('#left').on 'vmousedown', -> goDirection("left", this)
$ -> $('#left').on 'vmouseup', -> goDirection("stop", this, false)
$ -> $('#right').on 'vmousedown', -> goDirection("right", this)
$ -> $('#right').on 'vmouseup', -> goDirection("stop", this, false)
$ -> $('#stop').on 'vmousedown', -> goDirection("stop", this)
$ -> $('#stop').on 'vmouseup', -> goDirection("stop", this, false)

# Key presses
$ -> $('body').on 'keydown', (e) ->
  key = e.which
  unless window.previousKey == key
    if key == 38
      goDirection 'forward', $('#forward')
    else if key == 40
      goDirection 'back', $('#back')
    else if key == 37
      goDirection 'left', $('#left')
    else if key == 39
      goDirection 'right', $('#right')
    else if key == 83
      goDirection 'stop', $('#stop')
    window.previousKey = key

$ -> $('body').on 'keyup', (e) ->
  key = e.which
  el = null
  if key == 38
    el = $('#forward')
  else if key == 40
    el = $('#back')
  else if key == 37
    el = $('#left')
  else if key == 39
    el = $('#right')
  else if key == 83
    el = $('#stop')
  if key == 37 or key == 38 or key == 39 or key == 40 or key == 83
    goDirection 'stop', el, false
  window.previousKey = 0

window.previousKey = 0
