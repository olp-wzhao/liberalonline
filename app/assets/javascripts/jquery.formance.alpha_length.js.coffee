$ = jQuery

# subclass of the NumericFormanceField which is a subclass of the FormanceField
# there is also an AlphanumericFormanceField
class NewIncredibleField extends NumericFormanceField

  # restricts the length of the input field to 5 digits, all the formatting is stripped away
  restrict_field_callback: (e, $target, old_val, digit, new_val) =>
    return false if new_val.length > 5

  # this callback gets invoked every time the user enters a new digit
  format_field_callback: (e, $target, old_val, digit, new_val) =>
    if /^\d{2}$/.test(new_val)  # if the 2nd digit was entered, lets append a /
      e.preventDefault()
      $target.val "#{new_val} / "

  # this callback gets invoked when the user is backspacing
  format_backspace_callback: (e, $target, val) =>
    if /\d[\s|\/]+$/.test(val) # deletes the a digit and /
      e.preventDefault()
      $target.val val.replace(/\d[\s|\/]+$/, '')

  # there is a format_paste_callback as well, which you should implement
  # take a look at FormanceField for more details

  # gets called when the input must be validated
  validate: () ->
    return /^\d{2}[\s|\/]*\d{3}$/.test( @field.val() )

# exposes the fields format and validate methods for the api
$.formance.fn.format_new_incredible_field = ->
  field = new NewIncredibleField this
  field.format()
  this

$.formance.fn.validate_new_incredible_field = ->
  field = new NewIncredibleField this
  field.validate()