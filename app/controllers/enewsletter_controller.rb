class EnewsletterController < ApplicationController

	before_filter :authenticate_user!, only: [:show, :edit, :update, :destroy]

    layout "inside_layout"

    def subscribe

		@enewssubscriber_form_result = nil
		is_missing_name = true
		if params[:enews_subscribe_form_tname] != nil && params[:enews_subscribe_form_tname].strip != "" then is_missing_name = false end
		is_missing_email = true
		if params[:enews_subscribe_form_temail] != nil && params[:enews_subscribe_form_temail].strip != "" then is_missing_email = false end
		enews_frequency = ''
		if params[:enews_subscribe_form_rfrequency] == 'daily' then enews_frequency = 'd' end
		if params[:enews_subscribe_form_rfrequency] == 'weekly' then enews_frequency = 'w' end
		if params[:enews_subscribe_form_rfrequency] == 'monthly' then enews_frequency = 'm' end

		if is_missing_name && is_missing_email
			@enewssubscriber_form_result = nil
		elsif is_missing_email
			@enewssubscriber_form_result = "Please fill email information and submit again.\n"
		else
			enews_subscribers = EnewsSubscriber.find(:all, :order => "created_date DESC", :conditions => {:riding_id => @web_site_manager.r_id - 9000, :db_type => 'v', :email => CGI.unescapeHTML(params[:enews_subscribe_form_temail].strip)})
			if enews_subscribers != nil && enews_subscribers.length > 0
				@enewssubscriber_form_result = "Thanks. We already have you in our database.\n You are subscribed as:\n"
				@enewssubscriber_form_result += "Name:" + enews_subscribers[0].name + "\n"
			else
				enews_subscriber = EnewsSubscriber.new
				enews_subscriber.name = CGI.unescapeHTML(params[:enews_subscribe_form_tname].strip)
				enews_subscriber.email = CGI.unescapeHTML(params[:enews_subscribe_form_temail].strip)
				enews_subscriber.frequency = enews_frequency
				enews_subscriber.interested_in = ''
				enews_subscriber.is_html_format = true
				enews_subscriber.is_in_send_group = true
				enews_subscriber.is_in_test_group = false
				security_key = random_key_string
				while EnewsSubscriber.find_by_security_key(security_key) != nil
					security_key = random_key_string
				end
				enews_subscriber.security_key = security_key
				enews_subscriber.is_bad_email_address = false
				enews_subscriber.db_type = 'r'
				enews_subscriber.riding_id = @web_site_manager.r_id - 9000
				enews_subscriber.user_id = 0
				enews_subscriber.web_site = ''
				enews_subscriber.created_date = DateTime.now
				enews_subscriber.updated_time = DateTime.now
				#enews_subscriber.save
				@enewssubscriber_form_result = "Thank for subscribing to our enewsletter!\n  You are subscribed as:\n"
				@enewssubscriber_form_result += "Name:" + CGI.unescapeHTML(params[:enews_subscribe_form_tname].strip) + "\n"
			end
			@enewssubscriber_form_result += "Email:" + CGI.unescapeHTML(params[:enews_subscribe_form_temail].strip) + "\n"
		end
    end

end
