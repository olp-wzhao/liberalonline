class Users::SessionsController < Devise::SessionsController

  def new
    #redirect_to '/auth/facebook'
    #binding.pry
    self.resource = resource_class.new(sign_in_params)
    respond_to do |format|
      format.js
    end
  end


  def create
    resource = resource_class.new(sign_in_params)

    sign_in(resource, :bypass => true)
    binding.pry
    respond_to do |format|
      format.js
    end

  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
