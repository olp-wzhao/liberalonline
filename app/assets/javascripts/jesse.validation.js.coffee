window.Application ||= {}

window.Application.UserValidation = class UserValidation

  constructor: ->

  setup: ->
    success_animations_css_classes = "has-success animated tada"
    error_animations_css_classes = "has-error animated bounce"

    $("input#user_email").on "change blur", ->
      $this = $(this)
      console.log "unique email check"

      #Show the loading icon
      el = $("#checking_unique_email")
      el.show()
      console.log $this.data("url")
      $.getJSON($this.data("url") + "?email=" + $this.val()
      ).done((isEmailAlreadyTaken) ->
        console.log 'successful return of email validation'
        console.log "email already exists: " + isEmailAlreadyTaken
        setTimeout (->
          el.hide()
          if isEmailAlreadyTaken == false && $this.val() != ""
            #this is a unique address, but lets still check the formatting
            if $('input.email').formance('validate_email')
              console.log('email passes both unique and formatting validation')
              $this.parent().removeClass("has-success has-error").addClass("has-success").children(":last").html "Username is available"
            else
              console.log 'email does not exist but is in the wrong format'
              $this.parent().removeClass("has-success has-error").addClass("has-error").children(":last").html "Incomplete email address or incorrect format"
          else
            console.log 'email already exists'
            $this.parent().removeClass("has-success has-error").addClass("has-error").children(":last").html "Email already exists in our system"
          return
        ), 4000
        return
      ).fail((error) ->
        $this.removeClass("has-success has-error").children(":last").text "Invalid" + error
        return
      )
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

    $('.datepicker').datepicker()

    #lock in the ui
    $("input.datepicker").formance("format_dd_mm_yyyy").addClass("required")

    #Datepicker or Birthday field
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

    #Alpha only validation
    $("input.alpha_length").formance("format_alpha_length").addClass("required")

    #Datepicker or Birthday field
    $("input.alpha_length").on "keyup change blur", -> # setup the event listeners to validate the field whenever the user takes an action
      $this = $(this)
      if $this.formance("validate_alpha_length")
        $("input[type='submit']").prop "disabled", false
        $this.parent().removeClass("has-success has-error").addClass("has-success").children(":last").text ""
      else
        $("input[type='submit']").prop "disabled", true
        $this.parent().removeClass("has-success has-error").addClass("has-error").children(":last").text "Field cannot be empty"
      return


    fields = [
      #"credit_card_number"
      #"credit_card_expiry"
      #"credit_card_cvc"

      #'dd_mm_yyyy',
      #'yyyy_mm_dd',
      #"number"
      "phone_number"
      "postal_code"
      #"alpha_length"
    ]

    #phone number validation
    $("input.phone_number").formance("format_phone_number").addClass("required")#.addClass("form-control").wrap("<div class='form-group' />").parent().append "<label class='control-label'>Required!</label>"
    #move the placeholder text to the right of the textbox

    $("input.phone_number").on "keyup change blur", ->
      $this = $(this)
      #console.log("validate_" + value)
      if $this.formance("validate_phone_number")
        $("input[type='submit']").prop "disabled", false
        $this.parent().removeClass("has-success has-error").addClass(success_animations_css_classes).children(":last").text ""
      else
        $("input[type='submit']").prop "disabled", true
        $this.parent().removeClass("has-success has-error").addClass(error_animations_css_classes).children(":last").text "Phone number is invalid"
      return

    #postal code validation
    $("input.postal_code").formance("format_postal_code").addClass("required")#.addClass("form-control").wrap("<div class='form-group' />").parent().append "<label class='control-label'>Required!</label>"
    #move the placeholder text to the right of the textbox

    $("input.postal_code").on "keyup change blur", ->
      $this = $(this)
      #console.log("validate_" + value)
      if $this.formance("validate_postal_code")
        $("input[type='submit']").prop "disabled", false
        $this.parent().removeClass("has-success has-error").addClass(success_animations_css_classes).children(":last").text ""
        $.getJSON($this.data("url"),
          search: $this.val()
        ).done (data) ->
          $('.riding_details').remove()
          $this.append '<div class="riding_details"><span class="riding_box"></span><input type="hidden" id="riding_id" value="'+ data.id + '" /></div>'
          $(".riding_details").html data.name
          return
      else
        $("input[type='submit']").prop "disabled", true
        $this.parent().removeClass("has-success has-error").addClass(error_animations_css_classes).children(":last").text "Postal code invalid or missing"
      return