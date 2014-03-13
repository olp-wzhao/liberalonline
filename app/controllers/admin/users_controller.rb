class Admin::UsersController < Admin::AdminController
  before_filter :authenticate_admin!

  def index
    @users = User.order_by(:first_name.desc).page params[:page]
    respond_to do |format|
      format.js
      format.html
    end
  end

  def search
    @users = User.search(params['query']).page 0
    respond_to do |format|
      format.js
    end
  end

  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    #authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    set_user
    @user.delete
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :postal_code,:address, :phone_number, :roles => [])
    end
end