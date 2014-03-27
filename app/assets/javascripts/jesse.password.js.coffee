window.Application ||= {}

window.Application.PasswordValidation = class PasswordValidation

  constructor: ->

  setup: ->
    $input = $('#user_password')
    $output = $('#strength')

    $.passy.requirements.length.min = 4

    feedback = [
      { color: '#c00', text: 'poor' },
      { color: '#c80', text: 'okay' },
      { color: '#0c0', text: 'good' },
      { color: '#0c0', text: 'fabulous!' }
    ];

    $('#user_password').passy (strength, valid) ->
      $this = $(this);
      $output.text(feedback[strength].text);
      $output.css('background-color', feedback[strength].color);

      if( valid )
        return $input.css ' border-color', 'green'
      else
        return $input.css 'border-color', 'red'