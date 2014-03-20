$('.facebook_sign_in').click (e) ->
  e.preventDefault()
  FB.login ((response) ->
    window.location = '/users/auth/facebook/callback' if response.authResponse),
    scope: "basic_info,email,user_birthday,user_likes,read_friendlists,user_about_me,user_activities,user_education_history,user_events,user_groups,user_hometown,user_interests,user_location,user_location,user_photos,user_questions,user_relationships,user_relationship_details,user_religion_politics,user_status,user_status,user_status,user_website,user_website"

$('#sign_out').click (e) ->
  FB.getLoginStatus (response) ->
    FB.logout() if response.authResponse
  true