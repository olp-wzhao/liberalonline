class Admins::SessionsController < Devise::SessionsController
  def create
    # custom sign-in code
    #binding.pry
    super
  end

  def new
    #binding.pry
    super
  end

  def destroy
    #binding.pry
    super
  end
end