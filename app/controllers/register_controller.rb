class RegisterController < ApplicationController

    layout "inside_layout"

    def index

		if @olp_passport_user != nil
			redirect_to :controller => 'Profile'
		end

		month_str_hash = Hash.new
		month_str_hash["Jan"] = 1
		month_str_hash["Feb"] = 2
		month_str_hash["Mar"] = 3
		month_str_hash["Apr"] = 4
		month_str_hash["May"] = 5
		month_str_hash["Jun"] = 6
		month_str_hash["Jul"] = 7
		month_str_hash["Aug"] = 8
		month_str_hash["Sep"] = 9
		month_str_hash["Oct"] = 10
		month_str_hash["Nov"] = 11
		month_str_hash["Dec"] = 12

		@olp_user_register_form_result = nil
		@olp_passport_email = nil
		@olp_passport_password1 = nil
		@olp_passport_password2 = nil
		@olp_passport_fname = ''
		@olp_passport_lname = ''
		@olp_passport_address = ''
		@olp_passport_city = ''
		@olp_passport_dob_day = 0
		@olp_passport_dob_month = 0
		@olp_passport_dob_year = 0

		is_spambots = false
		if params[:OlpPassportComment] != nil && params[:OlpPassportComment].strip != "" then is_spambots = true end
		
		@is_missing_email = false
		if params[:OlpPassportEmail] != nil && params[:OlpPassportEmail].strip != "" then @olp_passport_email = CGI.unescapeHTML(params[:OlpPassportEmail]).strip else @is_missing_email = true end
		@is_missing_passowrd1 = false
		if params[:OlpPassportPassword1] != nil && params[:OlpPassportPassword1].strip != "" then @olp_passport_password1 = CGI.unescapeHTML(params[:OlpPassportPassword1]) else @is_missing_password1 = true end
		@is_missing_password2 = false
		if params[:OlpPassportPassword2] != nil && params[:OlpPassportPassword2].strip != "" then @olp_passport_password2 = CGI.unescapeHTML(params[:OlpPassportPassword2]) else @is_missing_password2 = true end

		@is_missing_fname = false
		if params[:OlpPassportFname] != nil && params[:OlpPassportFname].strip != "" then @olp_passport_fname = CGI.unescapeHTML(params[:OlpPassportFname]).strip else @is_missing_fname = true end
		@is_missing_lname = false
		if params[:OlpPassportLname] != nil && params[:OlpPassportLname].strip != "" then @olp_passport_lname = CGI.unescapeHTML(params[:OlpPassportLname]).strip else @is_missing_lname = true end
		@is_missing_address = false
		if params[:OlpPassportAddress] != nil && params[:OlpPassportAddress].strip != "" then @olp_passport_address = CGI.unescapeHTML(params[:OlpPassportAddress]).strip else @is_missing_address = true end
		@is_missing_city = false
		if params[:OlpPassportCity] != nil && params[:OlpPassportCity].strip != "" then @olp_passport_city = CGI.unescapeHTML(params[:OlpPassportCity]).strip else @is_missing_city = true end
		
		if params[:OlpPassportDobDay] != nil && params[:OlpPassportDobDay].strip != "" then @olp_passport_dob_day = params[:OlpPassportDobDay].to_i end
		if params[:OlpPassportDobMonth] != nil && params[:OlpPassportDobMonth].strip != "" then @olp_passport_dob_month_str = params[:OlpPassportDobMonth] end
		if params[:OlpPassportDobYear] != nil && params[:OlpPassportDobYear].strip != "" then @olp_passport_dob_year = params[:OlpPassportDobYear].to_i end

		# (?=.*\d) shows that the string should contain at least one integer.
		# (?=.*([a-z]|[A-Z])) shows that the string should contain at least one alphabet either from downcase or upcase.
		# ([\x20-\x7E]) shows that string can have special characters of ascii values 20 to 7E.
		# {6,20} shows that string should be minimum of 6 to maximum of 20 cahracters long.
		reg = /^(?=.*\d)(?=.*([a-z]|[A-Z]))([\x20-\x7E]){6,20}$/

		if is_spambots
			# deal with spambolts attack
		elsif @is_missing_email && @is_missing_password1 && @is_missing_password2 && @is_missing_fname && @is_missing_lname && @is_missing_address && @is_missing_city
			@olp_user_register_form_result = nil
		elsif @is_missing_email || @is_missing_password1 || @is_missing_password2
			@olp_user_register_form_result = "Please fill email and/or password and submit again."
		elsif @olp_passport_password1.eql?(@olp_passport_password2) == false
			@olp_user_register_form_result = "Password donot match."
		elsif reg.match(@olp_passport_password1) == nil
			@olp_user_register_form_result = "Password should contain at least one integer, one alphabet either downcase or upcase, and minimum of 6 to the maximum of 20 characters long."
		else
			@olp_user = OlpUser.find_by_email(CGI.unescapeHTML(params[:OlpPassportEmail]))
			if @olp_user != nil
				@olp_user_register_form_result = "Email already existed. Forget password? Click <a href='/Password'>here</a> to retrieve password."
			else
				olp_user = OlpUser.new
				security_key = random_key_string
				while Volunteer.find_by_security_key(security_key) != nil
					security_key = random_key_string
				end
				olp_user.security_key = security_key
				olp_user.email = @olp_passport_email
				olp_user.password = @olp_passport_password1
				olp_user.title = ""
				olp_user.last_name = @olp_passport_lname
				olp_user.first_name = @olp_passport_fname
				olp_user.address = @olp_passport_address
				olp_user.postal_code = ""
				olp_user.city = @olp_passport_city
				olp_user.phone_number = ""
				olp_user.available_date = DateTime.now
				olp_user.confirmed_date = DateTime.now
				olp_user.summary = ""
				olp_user.member_only = false
				olp_user.style = ""
				olp_user.attached_photo_ids = ""
				olp_user.attached_video_ids = ""
				olp_user.attached_pdf_ids = ""
				olp_user.created_date = DateTime.now
				olp_user.created_ip = @remote_ip
				olp_user.age = 0
				olp_user.dob_day = @olp_passport_dob_day
				olp_user.dob_month = month_str_hash[@olp_passport_dob_month_str].to_i
				olp_user.dob_year = @olp_passport_dob_year
				olp_user.gender = ""
				olp_user.person_type = 0
				olp_user.person_level = 0
				olp_user.confirmed = false
				olp_user.language = @language
				olp_user.canvassing = false
				olp_user.sign_crew = false
				olp_user.dropping_literature = false
				olp_user.office_work = false
				olp_user.election_day = false
				olp_user.driver = false
				olp_user.scrutineer = false
				olp_user.local_captain = false
				olp_user.availability_weekdays = false
				olp_user.availability_weeknights = false
				olp_user.availability_weekends = false
				olp_user.profile_extended = 0;
				olp_user.skill_set = ""
				olp_user.skill_set_note = ""
				olp_user.physical_limitation = ""
				olp_user.riding_id = @web_site_manager.r_id - 9000
				olp_user.user_id = 0
				olp_user.web_site = ""
				olp_user.updated_time = DateTime.now               
				if olp_user.save
					cookies[:OlpPassportKey] = olp_user.security_key
					@olp_passport_user = olp_user
				else
					@is_missing_email = true
					@olp_user_register_form_result = 'Invalid email.'
				end
			end
		end
	end

end
