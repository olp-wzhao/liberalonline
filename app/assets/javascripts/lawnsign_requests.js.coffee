# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.

$ ->
  $('#lawnsign_submit').disabled = false
  #$('input[type=submit]').attr('disabled', 'disabled');
  #show the first step
  $('#step1').show()
  $('#new_lawnsign_form').on('submit', (evt) ->
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
    return)

  $("#new_user_form").on('submit', (evt) ->
    evt.preventDefault()
    console.log 'trying to ajax send the form'

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
    return )
