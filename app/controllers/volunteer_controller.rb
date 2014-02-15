class VolunteerController < ApplicationController

    layout "inside_layout"

    def index
        
        if @olp_user != nil
			redirect_to :controller => 'VolunteerExtendedProfile'
        end
        
=begin        
        volunteers = Volunteer.find(:all)
        volunteers.each do |volunteer|
			if volunteer.security_key == nil || volunteer.security_key == ''
				security_key = random_key_string
				while Volunteer.find_by_security_key(security_key) != nil
					security_key = random_key_string
				end
				volunteer.security_key = security_key
				volunteer.save
			end
        end
=end

		@volunteer_result = nil

		is_missing_spambots = true
		if params[:volunteercommet] != nil && params[:volunteercommet].strip != "" then is_missing_spambots = false end

		is_missing_firstname = true
		if params[:volunteerfirstname] != nil && params[:volunteerfirstname].strip != "" then is_missing_firstname = false end
		is_missing_lastname = true
		if params[:volunteerlastname] != nil && params[:volunteerlastname].strip != "" then is_missing_lastname = false end
		is_missing_address = true
		if params[:volunteeraddress] != nil && params[:volunteeraddress].strip != "" then is_missing_address = false end
		is_missing_postalcode = true
		if params[:volunteerpostalcode] != nil && params[:volunteerpostalcode].strip != "" then is_missing_postalcode = false end
		is_missing_city = true
		if params[:volunteercity] != nil && params[:volunteercity].strip != "" then is_missing_city = false end
		is_missing_phonenumber = true
		if params[:volunteerphonenumber] != nil && params[:volunteerphonenumber].strip != "" then is_missing_phonenumber = false end
		is_missing_email = true
		if params[:volunteeremail] != nil && params[:volunteeremail].strip != "" then is_missing_email = false end

		is_missing_canvassing = true
		if params[:volunteercanvassing] != nil && params[:volunteercanvassing].strip != "" then is_missing_canvassing = false end
		is_missing_signcrew = true
		if params[:volunteersigncrew] != nil && params[:volunteersigncrew].strip != "" then is_missing_signcrew = false end
		is_missing_droppingliterature = true
		if params[:volunteerdroppingliterature] != nil && params[:volunteerdroppingliterature].strip != "" then is_missing_droppingliterature = false end
		is_missing_officework = true
		if params[:volunteerofficework] != nil && params[:volunteerofficework].strip != "" then is_missing_officework = false end
		is_missing_electionday = true
		if params[:volunteerelectionday] != nil && params[:volunteerelectionday].strip != "" then is_missing_electionday = false end
		is_missing_driver = true
		if params[:volunteerdriver] != nil && params[:volunteerdriver].strip != "" then is_missing_driver = false end
		is_missing_scrutineer = true
		if params[:volunteerscrutineer] != nil && params[:volunteerscrutineer].strip != "" then is_missing_scrutineer = false end
		is_missing_localcaptain = true
		if params[:volunteerlocalcaptain] != nil && params[:volunteerlocalcaptain].strip != "" then is_missing_localcaptain = false end

		is_availability_weekdays = false
		if params[:availabilityweekdays] != nil && params[:availabilityweekdays].strip != "" then is_availability_weekdays = true end
		is_availability_weeknights = false
		if params[:availabilityweeknights] != nil && params[:availabilityweeknights].strip != "" then is_availability_weeknights = true end
		is_availability_weekends = false
		if params[:availabilityweekends] != nil && params[:availabilityweekends].strip != "" then is_availability_weekends = true end

		if is_missing_firstname && is_missing_lastname && is_missing_address && is_missing_postalcode && is_missing_city && is_missing_phonenumber && is_missing_email && is_missing_canvassing && is_missing_signcrew && is_missing_droppingliterature && is_missing_officework && is_missing_electionday && is_missing_driver && is_missing_scrutineer && is_missing_localcaptain
			@volunteer_result = nil
		else
			if is_missing_firstname || is_missing_lastname || is_missing_address || is_missing_postalcode || is_missing_city || is_missing_phonenumber || is_missing_email
				@volunteer_result = "Thank you for your interest in volunteering.\nHowever you didnot fill in following information:\n"
				if is_missing_firstname then @volunteer_result += "First Name\n" end
				if is_missing_lastname then @volunteer_result += "Last Name\n" end
				if is_missing_address then @volunteer_result += "Address\n" end
				if is_missing_postalcode then @volunteer_result += "Postal Code\n" end
				if is_missing_city then @volunteer_result += "City\n" end
				if is_missing_phonenumber then @volunteer_result += "Phone Number\n" end
				if is_missing_email then @volunteer_result += "Email\n" end
				@volunteer_result += "Please go back to volunteer page and submit again. Thanks."
			else
				if is_missing_spambots               
					@volunteer_result = "Thank you for your interest in volunteering.\nHere is your information:\n"
					olp_user = OlpUser.find_by_email(CGI.unescapeHTML(params[:volunteeremail].strip).downcase)
					if olp_user == nil
						olp_user = OlpUser.new
						security_key = random_key_string
						while Volunteer.find_by_security_key(security_key) != nil
							security_key = random_key_string
						end
						olp_user.security_key = security_key
						olp_user.title = ""
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
						olp_user.gender = ""
						olp_user.person_type = 0
						olp_user.person_level = 0
						olp_user.confirmed = false
						olp_user.profile_extended = 0;
						olp_user.skill_set = ""
						olp_user.skill_set_note = ""
						olp_user.physical_limitation = ""
						olp_user.riding_id = @web_site_manager.r_id - 9000
						olp_user.user_id = 0
						olp_user.web_site = ""
					else
						@volunteer_result += "(You have already registered. Your information is updated.)\n"
					end
					olp_user.last_name = CGI.unescapeHTML(params[:volunteerlastname].strip)
					olp_user.first_name = CGI.unescapeHTML(params[:volunteerfirstname].strip)
					olp_user.address = CGI.unescapeHTML(params[:volunteeraddress].strip)
					olp_user.postal_code = CGI.unescapeHTML(params[:volunteerpostalcode].strip)
					olp_user.email = CGI.unescapeHTML(params[:volunteeremail].strip)
					olp_user.city = CGI.unescapeHTML(params[:volunteercity].strip)
					olp_user.phone_number = CGI.unescapeHTML(params[:volunteerphonenumber].strip)
					olp_user.language = @language
					olp_user.canvassing = !is_missing_canvassing
					olp_user.sign_crew = !is_missing_signcrew
					olp_user.dropping_literature = !is_missing_droppingliterature
					olp_user.office_work = !is_missing_officework
					olp_user.election_day = !is_missing_electionday
					olp_user.driver = !is_missing_driver
					olp_user.scrutineer = !is_missing_scrutineer
					olp_user.local_captain = !is_missing_localcaptain
					olp_user.availability_weekdays = is_availability_weekdays
					olp_user.availability_weeknights = is_availability_weeknights
					olp_user.availability_weekends = is_availability_weekends
					olp_user.updated_time = DateTime.now               
					olp_user.save
					cookies[:OlpUserKey] = olp_user.security_key
					@olp_user = olp_user
					volunteer_info = "First Name:" + CGI.unescapeHTML(params[:volunteerfirstname].strip) + "\n"
					volunteer_info += "Last Name:" + CGI.unescapeHTML(params[:volunteerlastname].strip) + "\n"
					volunteer_info += "Address:" + CGI.unescapeHTML(params[:volunteeraddress].strip) + "\n"
					volunteer_info += "Postal Code:" + CGI.unescapeHTML(params[:volunteerpostalcode].strip) + "\n"
					volunteer_info += "City:" + CGI.unescapeHTML(params[:volunteercity].strip) + "\n"
					volunteer_info += "Phone Number:" + CGI.unescapeHTML(params[:volunteerphonenumber].strip) + "\n"
					volunteer_info += "Email:" + CGI.unescapeHTML(params[:volunteeremail].strip) + "\n"
					#volunteer_info += "Volunteer activities checked:\n"
					#if is_missing_canvassing == false then volunteer_info += "Canvassing\n" end
					#if is_missing_signcrew == false then volunteer_info += "Sign Crew\n" end
					#if is_missing_droppingliterature == false then volunteer_info += "Dropping Literature\n" end
					#if is_missing_officework == false then volunteer_info += "Office Work\n" end
					#if is_missing_electionday == false then volunteer_info += "Election Day\n" end
					#if is_missing_driver == false then volunteer_info += "Driver\n" end
					#if is_missing_scrutineer == false then volunteer_info += "Scrutineer\n" end
					#if is_missing_localcaptain == false then volunteer_info += "Local Captain\n" end
					volunteer_info += "Volunteer availability checked:\n"
					if is_availability_weekdays then volunteer_info += "Weekdays\n" end
					if is_availability_weeknights then volunteer_info += "Weeknights\n" end
					if is_availability_weekends then volunteer_info += "Weekends\n" end
					@volunteer_result += volunteer_info
					#send_email(CGI.unescapeHTML(params[:volunteeremail].strip), @candidate_email, 'cc@not_used.email', 'philterrell@gmail.com', 'Volunteer Form Submit', volunteer_info)
					#send_email(CGI.unescapeHTML(params[:volunteeremail].strip), 'wzhao@ontarioliberal.ca', 'cc@not_used.email', 'philterrell@gmail.com', 'Volunteer Form Submit', volunteer_info)
					#send_email(CGI.unescapeHTML(params[:volunteeremail].strip), 'wzhao@ontarioliberal.ca', 'cc@not_used.email', 'philterrell@gmail.com', 'Volunteer Form Submit', volunteer_info)
				else
					@volunteer_result = "Thank you!\n"
					#send_email('spambots@ridingassociation.org', 'wzhao@ontarioliberal.ca', 'cc@not_used.email', 'philterrell@gmail.com', 'Volunteer Form Submit', volunteer_info + '\nURL:' + @url_str + '\nRemote IP:' + @remote_ip + '\nSPAMBOTS(volunteercommet):' + params[:volunteercommet])
				end
			end
		end
    end

end
