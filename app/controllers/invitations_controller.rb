class InvitationsController < Devise::InvitationsController
  def after_accept_path_for
   "some path you define"
  end  

  def update
    if this
      redirect_to root_path
    else
      super
    end
  end

  def create
  end

  def edit
    @user = User.where(invitation_token: params[:invitation_token]).first
    sign_in @user
    
    redirect_to root_path
  end
end