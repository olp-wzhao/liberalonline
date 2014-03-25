class EasySpin
  r = 0

  constructor: (spd, box_html_element) ->
    @spd = spd
    @box_html_element = box_html_element

  start: ->
    r += @spd;
    @box_html_element.css 'transform', 'rotate(' + r + 'deg)'
    requestAnimationFrame start
    return