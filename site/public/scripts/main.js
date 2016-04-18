// Generated by CoffeeScript 1.8.0
(function() {
  var goDirection;

  goDirection = function(direction, element, highlight) {
    var robot_id;
    if (element == null) {
      element = null;
    }
    if (highlight == null) {
      highlight = true;
    }
    console.log("going direction " + direction);
    robot_id = $('#controls').data('robot-id');
    if (highlight) {
      $(element).addClass('highlight');
    } else {
      $(element).removeClass('highlight');
    }
    return $.ajax({
      method: "get",
      url: "/" + robot_id + "/" + direction
    });
  };

  $(function() {
    return $('#forward').on('mousedown', function() {
      return goDirection("F", this);
    });
  });

  $(function() {
    return $('#forward').on('mouseup', function() {
      return goDirection("S", this, false);
    });
  });

  $(function() {
    return $('#back').on('mousedown', function() {
      return goDirection("B", this);
    });
  });

  $(function() {
    return $('#back').on('mouseup', function() {
      return goDirection("S", this, false);
    });
  });

  $(function() {
    return $('#left').on('mousedown', function() {
      return goDirection("L", this);
    });
  });

  $(function() {
    return $('#left').on('mouseup', function() {
      return goDirection("S", this, false);
    });
  });

  $(function() {
    return $('#right').on('mousedown', function() {
      return goDirection("R", this);
    });
  });

  $(function() {
    return $('#right').on('mouseup', function() {
      return goDirection("S", this, false);
    });
  });

  $(function() {
    return $('#stop').on('mousedown', function() {
      return goDirection("S", this);
    });
  });

  $(function() {
    return $('#send-command').on('mousedown', function() {
      return goDirection($('#command-input').val(), this, false);
    });
  });

  $(function() {
    return $('body').on('keydown', function(e) {
      var key;
      key = e.which;
      if (window.previousKey !== key) {
        if (key === 38) {
          goDirection('F', $('#forward'));
        } else if (key === 40) {
          goDirection('B', $('#back'));
        } else if (key === 37) {
          goDirection('L', $('#left'));
        } else if (key === 39) {
          goDirection('R', $('#right'));
        } else if (key === 83) {
          goDirection('S', $('#stop'));
        }
        return window.previousKey = key;
      }
    });
  });

  $(function() {
    return $('body').on('keyup', function(e) {
      var el, key;
      key = e.which;
      el = null;
      if (key === 38) {
        el = $('#forward');
      } else if (key === 40) {
        el = $('#back');
      } else if (key === 37) {
        el = $('#left');
      } else if (key === 39) {
        el = $('#right');
      } else if (key === 83) {
        el = $('#stop');
      }
      if (key === 37 || key === 38 || key === 39 || key === 40 || key === 83) {
        goDirection('S', el, false);
      }
      return window.previousKey = 0;
    });
  });

  window.previousKey = 0;

}).call(this);
