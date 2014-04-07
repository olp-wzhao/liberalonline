class Users::SessionsController < Devise::SessionsController

  def new
    self.resource = resource_class.new(sign_in_params)
    respond_to do |format|
      format.js {
        self.resource = resource_class.new(sign_in_params)
        clean_up_passwords(resource)
      }
      format.html { super }
    end
  end

  def edit
    respond_to do |format|
      format.js
      format.html { super }
    end
  end


  def create

    respond_to do |format|
      format.js {
        self.resource = User.where(email: sign_in_params[:email]).first
        if self.resource.nil?
          self.resource = User.new
          self.resource.errors.add(:email, 'does not exist in our database')
        else
          if
            sign_in self.resource
          else
            self.resource.errors.add(:password, 'missing or incorrect please try again')
          end
        end
      }
      format.html { super }
    end

  end

  # DELETE /resource/sign_out
  def destroy
    redirect_path = after_sign_out_path_for(resource_name)
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_navigational_format?
    #flash[:notice] = 'Signed out'

    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.js
      format.html { head :no_content }
      format.any(*navigational_formats) { redirect_to root }
    end
  end

end
