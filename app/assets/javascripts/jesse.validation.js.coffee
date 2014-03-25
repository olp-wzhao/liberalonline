window.Application ||= {}

window.Application.UserValidation = class UserValidation

  constructor: ->

  setup: ->
    success_animations_css_classes = "has-success animated tada"
    error_animations_css_classes = "has-error animated bounce"

#    passwordChecker = new StrongPass("user_password",
#      render: true
#      onPass: (score, verdict) ->
#        console.log "pass", score, verdict
#        return
#
#      onFail: (score, verdict) ->
#        console.log "fail", score, verdict
#        return
#    )

    $input = $('#user_password')
    $output = $('#strength')

    $.passy.requirements.length.min = 4

    feedback = [
      { color: '#c00', text: 'poor' },
      { color: '#c80', text: 'okay' },
      { color: '#0c0', text: 'good' },
      { color: '#0c0', text: 'fabulous!' }
    ];

    $('#user_password') (strength, valid) ->
      $this = $(this);
      $output.text(feedback[strength].text);
      $output.css('background-color', feedback[strength].color);

      if( valid ) $input.css(' border-color', 'green' )
      else $input.css( 'border-color', 'red' )

    $("input#user_email").formance("format_email").addClass("form-control").wrap("<div class='form-group' />").parent().append "<label class='control-label'>Required!</label>"
#    $("input#user_email").on "keyup", ->
#      ->
#        $this = $(this)
#        if $this.formance("validate_email")
#          $("input[type='submit']").prop "disabled", false
#          $this.parent().removeClass("has-success has-error").children(":last").addClass("has-success").text ""
#        else
#          $("input[type='submit']").prop "disabled", true
#          $this.parent().removeClass("has-success has-error").children(":last").addClass("has-error").text "Incomplete email address"
#        return

    $("input#user_email").on "change blur", ->
      $this = $(this)
      console.log "unique email check"

      #Show the loading icon
      el = $("#checking_unique_email")
      el.show()

      $.ajax(
        type: "GET"
        url: $this.data("url") + "?email=" + $this.val()
        dataType: "json"
      ).done((result) ->
        console.log "done ajax data from email validation check:: " + result
        if result
          $("input[type='submit']").prop "disabled", false
          $this.parent().removeClass("has-success has-error").addClass("has-success").children(":last").text ""
        else
          $("input[type='submit']").prop "disabled", true
          $this.parent().removeClass("has-success has-error").addClass("has-error").children(":last").html "Email already exists in our system"
        return
      ).fail((error) ->
        $this.removeClass("has-success has-error").children(":last").text "Invalid" + error
        return
      ).always ->
        setTimeout (->
          el.hide()
          return
        ), 4000
        return

      return

    $("#user_postal_code").blur ->
      $.getJSON("<%= find_riding_url %>",
        search: $("#user_postal_code").val()
      ).done (data) ->
        $("#riding_box").html data.name
        $("#riding_id").val data.riding_id
        return
      return

    $("input[type='submit']").prop "disabled", true # disable the submit button
    # setup the formatter
    $("input#user_password_confirmation").addClass("form-control").wrap("<div class='form-group' />").parent().append "<label class='control-label'>Required!</label>"
    $("input#user_password_confirmation").on "keypress keyup change blur", (event) ->
      $this = $(this)
      if ($this.val() is $("input#user_password").val()) and ($this.val() isnt "")
        $("input[type='submit']").prop "disabled", false
        $this.parent().removeClass("has-success has-error").addClass("has-success").children(":last").text ""
      else
        $("input[type='submit']").prop "disabled", true
        $this.parent().removeClass("has-success has-error").addClass("has-error").children(":last").text "Password must match and not be empty"
      return

    #Set all
    $ ->
      $("input.datepicker").each (i) ->
        $(this).datepicker dateFormat: "dd/mm/yy"

    #Datepicker or Birthday field
    # setup the formatter
    $("input.datepicker").formance("format_dd_mm_yyyy").addClass("form-control").wrap("<div class='form-group' />").parent().append "<label class='control-label'>Required!</label>"
    $("input.datepicker").on "keyup change blur", -> # setup the event listeners to validate the field whenever the user takes an action
      $this = $(this)
      birthday = moment($this.val(), "DD-MM-YYYY")
      thirteen_year_ago = moment().subtract("years", 13)
      if $this.formance("validate_dd_mm_yyyy") and birthday.isBefore(thirteen_year_ago)
        $("input[type='submit']").prop "disabled", false
        $this.parent().removeClass("has-success has-error").addClass("has-success").children(":last").text ""
      else
        $("input[type='submit']").prop "disabled", true
        $this.parent().removeClass("has-success has-error").addClass("has-error").children(":last").text "Must be at least 13 years old to register"
      return

    #Password Strength
    # setup the formatter
    $("input.datepicker").formance("format_dd_mm_yyyy").addClass("form-control").wrap("<div class='form-group' />").parent().append "<label class='control-label'>Required!</label>"

    fields = [
      "credit_card_number"
      "credit_card_expiry"
      "credit_card_cvc"

      #'dd_mm_yyyy',
      #'yyyy_mm_dd',
      "number"
      "phone_number"
      "postal_code"
      "alpha_length"
    ]

    $.each fields, (index, value) ->
      $("input." + value).formance("format_" + value).addClass("form-control").wrap("<div class='form-group' />").parent().append "<label class='control-label'>Required!</label>"
      $("input." + value).on "keyup change blur", (value) ->
        (event) ->
          $this = $(this)
          if $this.formance("validate_" + value)
            $("input[type='submit']").prop "disabled", false
            $this.parent().removeClass("has-success has-error").addClass(success_animations_css_classes).children(":last").text ""
          else
            $("input[type='submit']").prop "disabled", true
            $this.parent().removeClass("has-success has-error").addClass(error_animations_css_classes).children(":last").text "Invalid"
          return
      (value)
      return

    return