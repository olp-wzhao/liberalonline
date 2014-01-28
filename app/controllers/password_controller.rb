class PasswordController < ApplicationController

    layout "inside_layout"

    def index
        
		@olp_passport_user_password_form_result = nil

		@is_missing_email = false
		@olp_passport_email = ''
		if params[:OlpPassportEmail] != nil && params[:OlpPassportEmail].strip != "" then @olp_passport_email = CGI.unescapeHTML(params[:OlpPassportEmail]).strip else @is_missing_email = true end

		if @olp_passport_user != nil
			# already login
		elsif @is_missing_email
			# @olp_passport_user_password_form_result = "Please fill in your email before hitting submit."
		else
			olp_user = OlpUser.find_by_email(@olp_passport_email)
			if olp_user == nil
				@olp_passport_user_password_form_result = "Sorry, we can't find that email address in our database. Ensure you input your email correctly. Or create a new account. If you have any questions, you may contact the webadmin@ontarioliberal.ca."
			else
				olp_passport_user_email_message = "Here's your ontario liberal passport password:\n"
				olp_passport_user_email_message += CGI.unescapeHTML(olp_user.password) + "\n"
				olp_passport_user_email_message += "You're reciving this email because someone provided this email address and asked our website to resend login credentials. If this was not you it's safe to ignore this email since account information for your account will only ever be sent to this email address. If you have any questions, you may contact the webadmin@ontarioliberal.ca. Thanks."
				send_email('no-reply@ontarioliberal.ca', @olp_passport_email, '', 'wzhao@liberal.ola.org', 'Your ontario liberal passport account.', olp_passport_user_email_message)
				@olp_passport_user_password_form_result = "An email with the password has been sent to the email you entered. Please check your email inbox. If you don't see the email right away, check your junkmail folder or adjust your spam filter and try again."
			end
		end
    end

end
