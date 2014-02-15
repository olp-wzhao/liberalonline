class LoginController < ApplicationController

    layout "inside_layout"

    def index
			@olp_passport_user_form_result = nil
			@is_missing_email = false
			@olp_passport_email = ''
			if params[:OlpPassportEmail] != nil && params[:OlpPassportEmail].strip != "" then @olp_passport_email = CGI.unescapeHTML(params[:OlpPassportEmail]).strip else @is_missing_email = true end
			@is_missing_password = false
			@olp_passport_password = ''
			if params[:OlpPassportPassword] != nil && params[:OlpPassportPassword].strip != "" then @olp_passport_password = CGI.unescapeHTML(params[:OlpPassportPassword]) else @is_missing_password = true end

			if @olp_passport_user != nil
				# already login
				redirect_to :controller => 'MyLiberal'
			elsif @is_missing_email && @is_missing_password
				@olp_passport_user_form_result = nil
			elsif @is_missing_email || @is_missing_password
				@olp_passport_user_form_result = "Please fill email and/or password."
			else
				olp_user = OlpUser.find_by_email(@olp_passport_email)
				if olp_user != nil && olp_user.password.eql?(@olp_passport_password)
					@olp_passport_user = olp_user
					cookies[:OlpPassportKey] = @olp_passport_user.security_key
					redirect_to :controller => 'MyLiberal'
				else
					@olp_passport_user = nil
					cookies[:OlpPassportKey] = ''
					@olp_passport_user_form_result = "Email and password do not matching, please try again."
				end
			end
    end
    
    def show
			current_action = params[:id]
			if current_action == nil || current_action == '' then current_action = 'Home' end
			cookies[:OlpPassportKey] = ''
			redirect_to :controller => current_action
    end

end
