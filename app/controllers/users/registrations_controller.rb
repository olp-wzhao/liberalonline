class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters
  #include DateTimeFixes
  
  #before_update

  # def resource_params
  #   params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  # end
  # private :resource_params

  def new
    @user = User.new
    @user.birthday = Time.now
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    if current_user.nil?
      build_resource(sign_up_params)
    else

      @user.update_attributes(sign_up_params)
    end

    random_pass = Devise.friendly_token.first(8)
    resource.password = random_pass
    resource.password_confirmation = random_pass
    #check and assign riding
    if sign_up_params['riding_id'].empty?
      ridingAddresses = RidingAddress.near(sign_up_params[:postal_code], 10, :order => :distance)
      unless ridingAddresses.nil?
        riding = ridingAddresses.first.riding
      end
    else
      riding = Riding.find_by(riding_id: sign_up_params['riding_id'])
    end
      resource.riding = riding

    #date will be misbehaving until validation is modified to test the mm/dd/yyyy standard
    #the birthday will be converted by hand
    logger.debug sign_up_params[:birthday]
    resource.birthday = Date.strptime(sign_up_params[:birthday], '%d / %m / %Y')

    #attempt to save new user
    if resource.save
      logger.debug "User Saved: #{resource.id}".colorize(:green)
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_to do |format|
          format.html { redirect_to after_sign_up_path_for(resource) }
          format.js
        end
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_to do |format|
          format.html { redirect_to after_inactive_sign_up_path_for(resource) }
          format.js
        end
      end
    else
      logger.debug "Could not save the user due to the following errors: #{resource.errors.messages do |error|  error.message end }".colorize(:red)
      #facebook authentication creates an incomplete profile and so the user must be informed that their account is missing information
      clean_up_passwords resource
      respond_to do |format|
        format.html { redirect_to new_user_registration_path(resource) }
        format.js
      end
    end
  end

  def edit
    respond_to do |format|
      format.js
      format.html { super }
    end
  end

  def update
    account_update_params = devise_parameter_sanitizer.for(:account_update)

    @user = User.find(current_user.id)
    if @user.update_attributes(account_update_params)
      #errors.add("")
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to my_liberal_index_url
    else
      render 'edit'
    end
  end

  protected

  def after_sign_up_path_for(resource)
    my_liberal_index_path(resource)
  end

  def after_inactive_sign_up_path_for(resource)
    my_liberal_index_path(resource)
  end

  def fix_scrambled_date_parameters_on_edit
    x,y,z = params[:user][:"birthday(1i)"], params[:user][:"birthday(2i)"], params[:user][:"birthday(3i)"]
    @user.birthday = "#{z}/#{y}/#{x}".to_date

    params[:user].delete :"birthday(1i)"
    params[:user].delete :"birthday(2i)"
    params[:user].delete :"birthday(3i)"
  end

  def fix_scrambled_date_parameters_on_create
  x,y,z = params[:user][:"birthday(1i)"], params[:user][:"birthday(2i)"], params[:user][:"birthday(3i)"]
  params[:user][:birthday] = "#{z}/#{y}/#{x}"
  params[:user].delete :"birthday(1i)"
  params[:user].delete :"birthday(2i)"
  params[:user].delete :"birthday(3i)"
  end

  def assign_random_pass
    random_pass = Devise.friendly_token.first(6)
    params['password'] = random_pass
    params['password_confirmation'] = random_pass
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      #only assign random passwords on creation
      assign_random_pass
      #fix_scrambled_date_parameters_on_create
      u.permit(:first_name, :last_name,
        :email, :password, :password_confirmation,
        :address, :postal_code, :city, :phone_number,
        :birthday, :image, :image_cache, :riding_id, :birthday)
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      #fix_scrambled_date_parameters_on_create
      u.permit(:first_name, :last_name,
        :email, :password, :password_confirmation, :current_password,
        :address, :postal_code, :city, :phone_number,
        :birthday, :image, :image_cache, :riding_id, :birthday)
    end
  end

end