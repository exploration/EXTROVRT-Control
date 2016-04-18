# Method to call a robot to go into a direction
goDirection = (direction, element=null, highlight=true) ->
  console.log "going direction #{direction}"
  robot_id = $('#controls').data('robot-id')
  if highlight
    $(element).addClass('highlight')
  else
    $(element).removeClass('highlight')
  $.ajax
    method: "get"
    url: "/#{robot_id}/#{direction}"

# Mouse clicks on buttons
$ -> $('#forward').on 'mousedown', -> goDirection("F", this)
$ -> $('#forward').on 'mouseup', -> goDirection("S", this, false)
$ -> $('#back').on 'mousedown', -> goDirection("B", this)
$ -> $('#back').on 'mouseup', -> goDirection("S", this, false)
$ -> $('#left').on 'mousedown', -> goDirection("L", this)
$ -> $('#left').on 'mouseup', -> goDirection("S", this, false)
$ -> $('#right').on 'mousedown', -> goDirection("R", this)
$ -> $('#right').on 'mouseup', -> goDirection("S", this, false)
$ -> $('#stop').on 'mousedown', -> goDirection("S", this)
$ -> $('#send-command').on 'mousedown', -> goDirection($('#command-input').val(), this, false)

# Key presses
$ -> $('body').on 'keydown', (e) ->
  key = e.which
  unless window.previousKey == key
    if key == 38
      goDirection 'F', $('#forward')
    else if key == 40
      goDirection 'B', $('#back')
    else if key == 37
      goDirection 'L', $('#left')
    else if key == 39
      goDirection 'R', $('#right')
    else if key == 83
      goDirection 'S', $('#stop')
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
    goDirection 'S', el, false
  window.previousKey = 0

window.previousKey = 0
