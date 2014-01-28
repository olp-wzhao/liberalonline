class InvitationsController < Devise::InvitationsController
  def after_accept_path_for
#   binding.pry
   "some path you define"
  end  

  def update
    if this
     # binding.pry
      redirect_to root_path
    else
      super
    end
  end

  def create
 #   binding.pry
  end

  def edit
    @user = User.where(invitation_token: params[:invitation_token]).first
   # binding.pry
    sign_in @user
    
    redirect_to root_path
  end
end