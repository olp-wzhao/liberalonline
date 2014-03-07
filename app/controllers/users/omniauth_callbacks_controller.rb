class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    identity = Identity.from_omniauth(request.env["omniauth.auth"])
    @user = identity.find_or_create_user(current_user)
    if @user.valid?
      flash.notice = 'Signed in!'
      sign_in_and_redirect @user
    else
      sign_in @user
        render :json => { :success => (current_user ? true : false),
                          :current_user => current_user.as_json }

    end
  end

  def create
    auth = request.env['omniauth.auth']
    logger.debug "Auth variable: #{auth.inspect}"

    # Try to find authentication first
    identity = Identity.from_omniauth(request.env["omniauth.auth"])

    binding.pry

    #unless current_user
    #  # Request a new 60 day token using the current 2 hour token obtained from fb
    #  auth.merge!(extend_fb_token(auth['credentials']['token']))
    #  authentication.update_attribute("token", auth['extension']['token']) if authentication
    #
    #  unless authentication
    #    user = User.new
    #    user.apply_omniauth(auth)
    #    saved_status = user.save(:validate => false)
    #  end
    #
    #  # Add the new token and expiration date to the user's session
    #  #create_or_refresh_fb_session(auth)
    #  #if saved_status.nil? || saved_status
    #  #  user = authentication ? authentication.user : user
    #  #  sign_in(:user, user)
    #  #end
    #end

    render :json => { :success => (current_user ? true : false),
                      :current_user => current_user.as_json(:only => [:email]) }
  end

  def signout
    success = delete_fb_session && sign_out(:user)
    render :json => { :success => success.as_json }
  end

  alias_method :facebook, :all
  #alias_method :twitter, :all
end