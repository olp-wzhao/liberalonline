class Admins::SessionsController < Devise::SessionsController
  def create
    # custom sign-in code
    super
  end

  def new
    super
    #respond_to do |format|
    #  format.js
    #end
  end

  def destroy
    super
    #respond_to do |format|
    #  format.js
    #end
  end
end