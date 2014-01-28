class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters
  include DateTimeFixes
  
  #before_update

  # def resource_params
  #   params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  # end
  # private :resource_params

  def create
    super
  end

  def edit
    super

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
      render "edit"
    end
  end

  protected

  def after_sign_up_path_for(resource)
    my_liberal_index_path(resource)
  end

  def after_inactive_sign_up_path_for(resource)
    my_liberal_index_path(resource)
  end

  # def fix_scrambled_date_parameters_on_edit
  #   x,y,z = params[:user][:"birthday(1i)"], params[:user][:"birthday(2i)"], params[:user][:"birthday(3i)"]
  #   @user.birthday = "#{z}/#{y}/#{x}".to_date

  #   params[:user].delete :"birthday(1i)"
  #   params[:user].delete :"birthday(2i)"
  #   params[:user].delete :"birthday(3i)"
  # end

  def fix_scrambled_date_parameters_on_create
    x,y,z = params[:user][:"birthday(1i)"], params[:user][:"birthday(2i)"], params[:user][:"birthday(3i)"]
    params[:user][:birthday] = "#{z}/#{y}/#{x}"
    params[:user].delete :"birthday(1i)"
    params[:user].delete :"birthday(2i)"
    params[:user].delete :"birthday(3i)"
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      fix_scrambled_date_parameters_on_create
      u.permit(:first_name, :last_name,
        :email, :password, :password_confirmation,
        :address, :postal_code, :city, :phone_number,
        :birthday, :image)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      fix_scrambled_date_parameters_on_create
      u.permit(:first_name, :last_name,
        :email, :password, :password_confirmation, :current_password,
        :address, :postal_code, :city, :phone_number,
        :birthday, :image)
    end
  end

end