window.Application ||= {}

window.Application.AwesomeForm = class AwesomeForm

  awesome_fields: ->
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
    success_animations_css_classes = "has-success animated wobble"
    error_animations_css_classes = "has-error animated flash"
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
