# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$.ajax({
  type: 'POST',
  url: '../oauth/token.json',
# url: 'http://api.geonames.org/citiesJSON',
  dataType: 'JSON',
  data: {
  # north: 44.1,
  # south: -9.9,
  # east: 22.4,
  # west: 55.2,
  # lang: 'de',
  # username: 'demo'
    email: 'jessenaiman@gmail.com',
    password: 'Naiman123'
    grant_type: 'client_credentials',
    client_id: '1e1bf9712365861964839722640e23bdb51beaee05413acce2d2fe2f48ed69cd',
    client_secret: '40ac466fc3bf3d4397b183f95eaeedfa2a6895866f199d51bbb5375b9c16433f'
  },
  success: (d, textStatus, jqXHR) ->
    console.debug d, textStatus
  error: (jqXHR, textStatus, errorThrown) ->
    console.debug jqXHR, textStatus, errorThrown
})