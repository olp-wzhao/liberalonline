# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.

$ ->
  #hide all steps

  #the validation for users currently disables all form buttons, so we're going to re-enable the lawnsign button
  $('#lawnsign_submit').disabled = false

  #show the first step
  $('#step1').show()
  $('#new_lawnsign_form').submit (evt) ->
    $this = $(this)
    data = $this.serialize()
    console.log data || 'empty'
    $.ajax
      type:     "POST"
      dataType: "json"
      url: $this.attr('action')
      data: data
      success: (data) ->
        $('#step2').show()
        $('#sign_in').hide()
        #$('#user_birthday').hide()
        $("#new_lawnsign_form > input[type='submit']").hide()
    evt.preventDefault()
    return

  $("#new_user_form").submit (evt) ->
    evt.preventDefault()
    #window.history.back()
    return
