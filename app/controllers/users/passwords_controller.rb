class Users::PasswordsController < Devise::PasswordsController

  def new
    super
    respond_to do |format|
      format.js
      format.html
    end
  end

  def edit
    super
    respond_to do |format|
      format.js
      format.html
    end
  end

  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
  private :resource_params
end