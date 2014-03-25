#
# ---
#
# name: StrongPass.js
#
# description: checks password strength of a string
#
# authors: Dimitar Christoff
#
# license: MIT-style license.
#
# version: 1.0.3
#
# requires:
# - Core/String
# - Core/Element
# - Core/DOMEvent
# - Core/Class
# - Core/Array
#
# provides: StrongPass
#
# ...
# 
# too short while less than this
# Weak

# output verdicts, colours and bar %

# tweak scores here

# when in banned list, verdict is:

# styles
# css controls

# output
# it can just report for your own implementation

# see study here: http://smrt.io/JlNfrH

###
@constructor
@param {DOMElement} element Base element to attach to
@param {Object} options* Options to merge in / attach events from
@fires StrongPass#ready
@returns SrongPass
###

###
@description Attaches events and saves a reference
@returns {StrongPass}
###

# only attach events once so freshen

###
@description Attaches pass elements.
@returns {StrongPass}
###

#todo: should be templated

###
@description Runs a password check on the keyup event
@param {Object} event*
@param {String} password* Optionally pass a string or go to element getter
@fires StrongPass#fail StrongPass#pass
@returns {StrongPass}
###

###
@event StrongPass#fail,StrongPass#pass
###

###
@type {Array}
@description The collection of regex checks and how much they affect the scoring
###

# alphaLower 

# alphaUpper 

# mixture of upper and lowercase 

# threeNumbers 

# special chars 

# multiple special chars 

# all together now, does it look nice? 

# password of a single char sucks 

# bonus for length per char

# return an AMD module

# exports to global object

# change to any object / ns
window.Application ||= {}

window.Application.StrongPass = class StrongPass
  options:
    minChar: 6
    passIndex: 2
    label: "Password strength: "
    verdicts: [
      "Too Short"
      "Very weak"
      "Weak"
      "Good"
      "Strong"
      "Very strong"
    ]
    colors: [
      "#ccc"
      "#500"
      "#800"
      "#f60"
      "#050"
      "#0f0"
    ]
    width: [
      "0%"
      "10%"
      "30%"
      "60%"
      "80%"
      "100%"
    ]
    scores: [
      10
      15
      25
      45
    ]
    bannedPass: "Not allowed"
    passStrengthZen: "div.pass-container"
    passbarClassZen: "div.pass-bar"
    passbarHintZen: "div.pass-hint"
    render: true
    injectTarget: null
    injectPlacement: "after"

  bannedPasswords: [
    "123456"
    "12345"
    "123456789"
    "password"
    "iloveyou"
    "princess"
    "rockyou"
    "1234567"
    "12345678"
    "abc123"
    "nicole"
    "daniel"
    "babygirl"
    "monkey"
    "jessica"
    "lovely"
    "michael"
    "ashley"
    "654321"
    "qwerty"
    "password1"
    "welcome"
    "welcome1"
    "password2"
    "password01"
    "password3"
    "p@ssw0rd"
    "passw0rd"
    "password4"
    "password123"
    "summer09"
    "password6"
    "password7"
    "password9"
    "password8"
    "welcome2"
    "welcome01"
    "winter12"
    "spring2012"
    "summer12"
    "summer2012"
  ]

  constructor: (element, options) ->
    @setOptions options
    @element = document.getElementById(element)
    @options.render and @createBox()
    @attachEvents()
    @fireEvent "ready"
    return

  attachEvents: ->
    @eventObj and @element.removeEvents(@eventObj)
    @element.addEvents @eventObj = keyup: @runPassword.bind(this)
    this

  createBox: ->
    width = @element.getSize().x
    o = @options
    @stbox = new Element(o.passStrengthZen,
      styles:
        width: width
    )
    @stdbar = new Element(o.passbarClassZen,
      styles:
        width: width - 2
    ).inject(@stbox)
    @txtbox = new Element(o.passbarHintZen).inject(@stbox)
    @stbox.inject (document.id(o.injectTarget) or @element), o.injectPlacement
    this

  runPassword: (event, password) ->
    password = password or @element.get("value")
    score = @checkPassword(password)
    index = 0
    o = @options
    s = Array.clone(o.scores)
    verdict = undefined
    if Array.indexOf(@bannedPasswords, password.toLowerCase()) isnt -1
      @fireEvent "banned", password
      verdict = o.bannedPass
    else
      if score < 0 and score > -199
        index = 0
      else
        s.push score
        s.sort (a, b) ->
          a - b

        index = s.indexOf(score) + 1
      verdict = o.verdicts[index] or o.verdicts.getLast()
    if o.render
      @txtbox.set "text", [
        o.label
        verdict
      ].join("")
      @stdbar.setStyles
        width: o.width[index] or o.width.getLast()
        background: o.colors[index] or o.colors.getLast()

    @fireEvent [
      "fail"
      "pass"
    ][+(@passed = o.verdicts.indexOf(verdict) >= o.passIndex)], [
      index
      verdict
      password
    ]

  checks: [
    {
      re: /[a-z]/
      score: 1
    }
    {
      re: /[A-Z]/
      score: 5
    }
    {
      re: /([a-z].*[A-Z])|([A-Z].*[a-z])/
      score: 2
    }
    {
      re: /(.*[0-9].*[0-9].*[0-9])/
      score: 7
    }
    {
      re: /.[!@#$%^&*?_~]/
      score: 5
    }
    {
      re: /(.*[!@#$%^&*?_~].*[!@#$%^&*?_~])/
      score: 7
    }
    {
      re: /([a-zA-Z0-9].*[!@#$%^&*?_~])|([!@#$%^&*?_~].*[a-zA-Z0-9])/
      score: 3
    }
    {
      re: /(.)\1+$/
      score: 2
    }
  ]
  checkPassword: (pass) ->
    score = 0
    minChar = @options.minChar
    len = pass.length
    diff = len - minChar
    (diff < 0 and (score -= 100)) or (diff >= 5 and (score += 18)) or (diff >= 3 and (score += 12)) or (diff is 2 and (score += 6))
    Array.each @checks, (check) ->
      pass.match(check.re) and (score += check.score)
      return

    score and (score += len)
    score