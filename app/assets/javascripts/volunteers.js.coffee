# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.

$ ->

  #the validation for users currently disables all form buttons, so we're going to re-enable the lawnsign button
  $('#lawnsign_submit').disabled = false

  #show the first step
  #$('#step1').show()

  $('#simple_volunteer_form').submit (evt) ->
    $this = $(this)
    data = $this.serialize()
    #console.log data
    $.ajax
      type:     "POST"
      dataType: "json"
      url: $this.attr('action')
      data: data
      success: (data) ->
        $('#step2').show()
        $('#step1').hide()
        #$('#user_birthday').hide()
        $("#simple_volunteer_form > input[type='submit']").hide()
    evt.preventDefault()
    return

  $("#new_user_form").submit (evt) ->
    evt.preventDefault()
    #window.history.back()
    $this = $(this)
    data = $this.serialize()
    $.ajax
      type:     "POST"
      dataType: "json"
      url: $this.attr('action')
      data: data
      success: (data) ->
        $('#step3').show()
        $('#step2').hide()
    return



