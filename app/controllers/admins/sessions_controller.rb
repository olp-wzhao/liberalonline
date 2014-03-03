class Admins::SessionsController < Devise::SessionsController
  def create
    # custom sign-in code
    #binding.pry
    super
  end

  def new
    #binding.pry
    super
    #respond_to do |format|
    #  format.js
    #end
  end

  def destroy
    #binding.pry
    super
    #respond_to do |format|
    #  format.js
    #end
  end
end