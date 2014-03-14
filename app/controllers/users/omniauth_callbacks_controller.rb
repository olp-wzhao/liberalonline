class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    identity = Identity.from_omniauth(request.env["omniauth.auth"])
    @user = identity.find_or_create_user(current_user)
    #a completely valid user has already registered previously

    if @user.valid?
      flash.notice = 'Welcome back to the Ontario Liberal Website'
      sign_in_and_redirect @user
    else
      #this user has never signed in before using
      flash[:notice] = "Thank you for creating an account, please visit your profile to complete registration"
      sign_in @user
      respond_to do |format|
        format.html { redirect_to root_url }
        format.json { render :json => { :success => (current_user ? true : false),
                          :current_user => current_user.as_json } }
      end
    end
  end

  def create
    auth = request.env['omniauth.auth']
    logger.debug "Auth variable: #{auth.inspect}"

    # Try to find authentication first
    identity = Identity.from_omniauth(request.env["omniauth.auth"])

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