$('.facebook_sign_in').click (e) ->
  e.preventDefault()
  FB.login (response) ->
    window.location = '/users/auth/facebook/callback' if response.authResponse

$('#sign_out').click (e) ->
  FB.getLoginStatus (response) ->
    FB.logout() if response.authResponse
  true