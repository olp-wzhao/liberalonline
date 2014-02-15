class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session
  #before_filter :check_registration
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :load_application_action, :load_application_layout, :most_recent_event

  layout :layout_by_resource

  def layout_by_resource
    if devise_controller? && resource_name == :admin
      "admin"
    else
      "application"
    end
  end

  #this is supposed to handle csrf token errors
  def verified_request?
    if request.content_type == "application/json"
      true
    else
      super()
    end
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to "/", :alert => exception.message
  end

  include NewsExtras

  @@myliberal_dev_site_user = 'DevSite'
  @@myliberal_dev_site_pswd = 'DevPass'



  def secure_ip_by_country
    #is_secure = false
    is_secure = true
    #remote_ip = request.remote_ip
    #if remote_ip == nil then remote_ip = request.env["HTTP_X_FORWARDED_FOR"] end
    #if remote_ip == nil then remote_ip = '' end
    #country_code = Net::HTTP.get_response(URI.parse('http://api.hostip.info/country.php?ip=' + remote_ip)).body
    #if country_code != nil && country_code == 'CA' then is_secure = true end
    
    is_secure
  end

  def most_recent_event
    @most_recent_event = Event.gt(expiry_date: DateTime.now).order_by(:expiry_date.desc).first
  end

  def load_application_action(home_action=false)
    unless request.content_type == "application/json"
      @webskin = 'A2'
      @allow_google_index = false

      
      @twitter_facebook = nil

      @send_forward_url = ''

      @html_head_value_vmmpxl_home = nil
      @html_head_value_vmmpxl_inside = nil

      if @twitter_facebook != nil && @twitter_facebook.facebook_flag && @twitter_facebook.facebook_account != ""
          if @twitter_facebook.facebook_account.start_with?("/")
              @twitter_facebook.facebook_account = "http://www.facebook.com" + @twitter_facebook.facebook_account
          elsif !@twitter_facebook.facebook_account.start_with?("http://www.facebook.com/")
              @twitter_facebook.facebook_account = "http://www.facebook.com/" + @twitter_facebook.facebook_account
          end
      end

      @is_facebook_user_login = false;
      @fu_id = cookies[:fu_id]
      @fu_name = cookies[:fu_name]
      @fu_gender = cookies[:fu_gender]
      @fu_bio = cookies[:fu_bio]
      if @fu_id != nil && @fu_id != ''
        @is_facebook_user_login = true;
      end
          
      @olp_user = nil
      if cookies[:OlpUserKey] != nil && cookies[:OlpUserKey] != ''
        @olp_user = OlpUser.find_by_security_key(cookies[:OlpUserKey].to_s)
      end
    end
  end

  def riding_id
      current_user.nil? ? 0 : current_user.riding.riding_id - 9000
  end
    
  def load_application_layout

    unless request.content_type == "application/json"
      # Time.zone = 'Eastern Time (US & Canada)'

      # set language parameter
      @language = "EN"
      if params[:l] != nil && params[:l].upcase == "FR" then @language = "FR" end

      @remote_ip = request.env["HTTP_X_FORWARDED_FOR"]
      if @remote_ip == nil || @remote_ip == '' then @remote_ip = request.remote_ip end

      if @web_site_type == 'candidate'
        @web_site_title = (@language == 'FR' ? ('Voter ' + @web_site_manager.c_nf + ' ' + @web_site_manager.c_nl + ' pour le ' + @web_site_manager.r_name_fr + ' de MPP - le Jour d&#39;Election est le 6 september, 2012') : ('Vote ' + @web_site_manager.c_nf + ' ' + @web_site_manager.c_nl + ' for MPP ' + @web_site_manager.r_name_en + ' - Election Day is September 6, 2012'))
        @web_site_og_title = (@language == 'FR' ? ('Voter ' + @web_site_manager.c_nf + ' ' + @web_site_manager.c_nl + ' pour le ' + @web_site_manager.r_name_fr + ' de MPP - le Jour d&#39;Election est le 6 september, 2012') : ('Vote ' + @web_site_manager.c_nf + ' ' + @web_site_manager.c_nl + ' for MPP ' + @web_site_manager.r_name_en + ' - Election Day is September 6, 2012'))
        @web_site_og_site_name = (@language == 'FR' ? ('Voter ' + @web_site_manager.c_nf + ' ' + @web_site_manager.c_nl + ' pour le ' + @web_site_manager.r_name_fr + ' de MPP - le Jour d&#39;Election est le 6 september, 2012') : ('Vote ' + @web_site_manager.c_nf + ' ' + @web_site_manager.c_nl + ' for MPP ' + @web_site_manager.r_name_en + ' - Election Day is September 6, 2012'))
        @web_site_og_description = (@language == 'FR' ? ('Voter ' + @web_site_manager.c_nf + ' ' + @web_site_manager.c_nl + ' pour le ' + @web_site_manager.r_name_fr + ' de MPP - le Jour d&#39;Election est le 6 september, 2012') : ('Vote ' + @web_site_manager.c_nf + ' ' + @web_site_manager.c_nl + ' for MPP ' + @web_site_manager.r_name_en + ' - Election Day is September 6, 2012'))
        @web_site_og_image = 'http://pantone201.ca/webskins/vote/candidate_photos/' + @web_site_manager.r_id.to_s + '.jpg'
        @web_site_og_url = 'http://' + @url_str
      end

      @menu_news_documents = prepare_news_documents.limit(4)
  	  @menu_photo = prepare_menu_photo
      @menu_video = prepare_menu_video
      @menu_event_document = prepare_menu_event_document
        
        #Photo.find(:all, :limit => 1, :order => "created_date DESC", :conditions => {:riding_id => 0, :published => true})

      @display_right_side_column = true;

      #we are using better metrics from now on!!
      # if !@is_test_site
      #   add_web_site_visit_count(@web_site_manager.r_id, @remote_ip, @url_str, request.request_uri)
      # end
    end
  end

    

    def load_enews_subscriber_layout
        @enews_subscribe_label_str = 'Campaign Alerts'
        if @language == 'FR' then @enews_subscribe_label_str = 'Recevez des nouvelles et des notifications' end

        # set defalut enews subscribe result label
        @subscribe_result = " "
        if params[:emailaddress] != nil && params[:emailaddress].strip != "" && params[:emailaddress].strip != "youremail@here.ca"
            enews_subscribers = EnewsSubscriber.find(:all, :conditions => {:riding_id => @web_site_manager.r_id - 9000, :email => params[:emailaddress].strip.downcase})
            if enews_subscribers != nil && enews_subscribers.length > 0
                if @language == 'FR'
                    @subscribe_result = 'D&eacute;j&agrave; l&#39;avait.'
                else
                    @subscribe_result = 'Already had it.'
                end
            else
                security_key = random_key_string
                same_security_key_enews_subscriber = EnewsSubscriber.find_by_security_key(security_key)
                while same_security_key_enews_subscriber != nil
                    security_key = random_key_string
                    same_security_key_enews_subscriber = EnewsSubscriber.find_by_security_key(security_key)
                end
                enews_subscriber = EnewsSubscriber.new
                enews_subscriber.name = ''
                enews_subscriber.email = params[:emailaddress].strip.downcase
                enews_subscriber.is_html_format = true
                enews_subscriber.is_in_send_group = true
                enews_subscriber.is_in_test_group = false
                enews_subscriber.security_key = security_key
                enews_subscriber.riding_id = @web_site_manager.r_id - 9000
                enews_subscriber.user_id = -1
                enews_subscriber.web_site = ''
                enews_subscriber.created_date = DateTime.now

                enews_subscriber.updated_time = DateTime.now
                enews_subscriber.save

                if @language == 'FR'
                    @subscribe_result = 'Le Merci, l&#39;a Re&ccedil;u!'
                else
                    @subscribe_result = 'Thanks, Got it!'
                end
            end
        end
    end

    def load_sidecolumn_documents
        # Get all the central issue documents
        @sidecolumn_issue_documents = nil
        @sidecolumn_accomplishment_documents = nil
    if @web_site_type == 'mpp'
      @sidecolumn_accomplishment_documents = Document.mpp.where(doctype: 7, language: @language)
    elsif @web_site_type == 'pla'
      @sidecolumn_accomplishment_documents = Document.pla.where(doctype: 7, language: @language)
    else
      @sidecolumn_accomplishment_documents = Document.elect.where(doctype: 7, language: @language)
    end
        # Get photo for the central accomplishment document
        if @sidecolumn_accomplishment_documents != nil && @sidecolumn_accomplishment_documents.length > 0
            @sidecolumn_accomplishment_documents.each do |document|
                document = prepare_document_photo(document, false)
            end
        end
        # Get all the local accomplishment documents include photo url if riding is not central
        if @web_site_manager.r_id - 9000 != 0
      sidecolumn_local_accomplishment_documents = nil
      if @web_site_type == 'mpp'
        sidecolumn_local_accomplishment_documents = MppDocument.where(:riding_id => @web_site_manager.r_id - 9000, :doctype => 7, :published => true, :language => @language)
                                                              .order_by(:document_date.desc)
      elsif @web_site_type == 'pla'
        sidecolumn_local_accomplishment_documents = PlaDocument.where(:riding_id => @web_site_manager.r_id - 9000, :doctype => 7, :published => true, :language => @language)
                                                              .order_by(:document_date.desc)
      else
        sidecolumn_local_accomplishment_documents = ElectDocument.where(:riding_id => @web_site_manager.r_id - 9000, :doctype => 7, :published => true, :language => @language)
                                                              .order_by(:document_date.desc)
      end
            if sidecolumn_local_accomplishment_documents != nil && sidecolumn_local_accomplishment_documents.length > 0
                if @sidecolumn_accomplishment_documents == nil
                    @sidecolumn_accomplishment_documents = Array.new
                end
                sidecolumn_local_accomplishment_documents.each do |document|
                    document = prepare_document_photo(document, true)
                    @sidecolumn_accomplishment_documents << document
                end
            end
        end
        # Sort accomplishment documents by date
        @sidecolumn_accomplishment_documents.sort! {|x ,y| y.document_date <=> x.document_date}
        # Keep first 6 accomplishment documents and delete all the rest
        while @sidecolumn_accomplishment_documents.length > 5
            @sidecolumn_accomplishment_documents.delete_at(5)
        end

        # Get all the central news documents
        @sidecolumn_news_documents = nil
    if @web_site_type == 'mpp'
      @sidecolumn_news_documents = Document.mpp #find(:all, :order => "document_date DESC", :conditions => {:riding_id => 0, :doctype => 0..1, :published => true, :publish_on_mpp => true, :language => @language})
    elsif @web_site_type == 'pla'
      @sidecolumn_news_documents = Document.pla #find(:all, :order => "document_date DESC", :conditions => {:riding_id => 0, :doctype => 0..1, :published => true, :publish_on_pla => true, :language => @language})
    else
      @sidecolumn_news_documents = Document.find(:all, :order => "document_date DESC", :conditions => {:riding_id => 0, :doctype => 0..1, :published => true, :publish_on_elect => true, :language => @language})
    end
        # Get photo for the central news document
        if @sidecolumn_news_documents != nil && @sidecolumn_news_documents.length > 0
            @sidecolumn_news_documents.each do |document|
                document = prepare_document_photo(document, false)
            end
        end
        # Get all the local news documents include photo url if riding is not central
        if @web_site_manager.r_id - 9000 != 0
      sidecolumn_local_news_documents = nil
      if @web_site_type == 'mpp'
        sidecolumn_local_news_documents = MppDocument.find(:all, :order => "document_date DESC", :conditions => {:riding_id => @web_site_manager.r_id - 9000, :doctype => 0..1, :published => true, :language => @language})
      elsif @web_site_type == 'pla'
        sidecolumn_local_news_documents = PlaDocument.find(:all, :order => "document_date DESC", :conditions => {:riding_id => @web_site_manager.r_id - 9000, :doctype => 0..1, :published => true, :language => @language})
      else
        sidecolumn_local_news_documents = ElectDocument.find(:all, :order => "document_date DESC", :conditions => {:riding_id => @web_site_manager.r_id - 9000, :doctype => 0..1, :published => true, :language => @language})
      end
            if sidecolumn_local_news_documents != nil && sidecolumn_local_news_documents.length > 0
                if @sidecolumn_news_documents == nil
                    @sidecolumn_news_documents = Array.new
                end
                sidecolumn_local_news_documents.each do |document|
                    document = prepare_document_photo(document, true)
                    @sidecolumn_news_documents << document
                end
            end
        end
        # Sort news documents by date
        @sidecolumn_news_documents.sort! {|x ,y| y.document_date <=> x.document_date}
        # Keep first 6 news documents and delete all the rest
        while @sidecolumn_news_documents.length > 5
            @sidecolumn_news_documents.delete_at(5)
        end


        # Get all the central blog documents
        @sidecolumn_blog_documents = nil
    if @web_site_type == 'mpp'
      @sidecolumn_blog_documents = Document.find(:all, :order => "document_date DESC", :conditions => {:riding_id => 0, :doctype => 3, :published => true, :publish_on_mpp => true, :language => @language})
    elsif @web_site_type == 'pla'
      @sidecolumn_blog_documents = Document.find(:all, :order => "document_date DESC", :conditions => {:riding_id => 0, :doctype => 3, :published => true, :publish_on_pla => true, :language => @language})
    else
      @sidecolumn_blog_documents = Document.find(:all, :order => "document_date DESC", :conditions => {:riding_id => 0, :doctype => 3, :published => true, :publish_on_elect => true, :language => @language})
    end
        # Get photo for the central blog document
        if @sidecolumn_blog_documents != nil && @sidecolumn_blog_documents.length > 0
            @sidecolumn_blog_documents.each do |document|
                document = prepare_document_photo(document, false)
                document = prepare_document_author(document, false)
            end
        end
        # Get all the local blog documents include photo url if riding is not central
        if @web_site_manager.r_id - 9000 != 0
      sidecolumn_local_blog_documents = nil
      if @web_site_type == 'mpp'
        sidecolumn_local_blog_documents = MppDocument.find(:all, :order => "document_date DESC", :conditions => {:riding_id => @web_site_manager.r_id - 9000, :doctype => 3, :published => true, :language => @language})
      elsif @web_site_type == 'pla'
        sidecolumn_local_blog_documents = PlaDocument.find(:all, :order => "document_date DESC", :conditions => {:riding_id => @web_site_manager.r_id - 9000, :doctype => 3, :published => true, :language => @language})
      else
        sidecolumn_local_blog_documents = ElectDocument.find(:all, :order => "document_date DESC", :conditions => {:riding_id => @web_site_manager.r_id - 9000, :doctype => 3, :published => true, :language => @language})
      end
            if sidecolumn_local_blog_documents != nil && sidecolumn_local_blog_documents.length > 0
                if @sidecolumn_blog_documents == nil
                    @sidecolumn_blog_documents = Array.new
                end
                sidecolumn_local_blog_documents.each do |document|
                    document = prepare_document_photo(document, true)
                    document = prepare_document_author(document, false)
                    @sidecolumn_blog_documents << document
                end
            end
        end
        # Sort blog documents by date
        @sidecolumn_blog_documents.sort! {|x ,y| y.document_date <=> x.document_date}
        # Keep first 6 blog documents and delete all the rest
        while @sidecolumn_blog_documents.length > 5
            @sidecolumn_blog_documents.delete_at(5)
        end
    end
    
    def prepare_document_photo(document, is_local, is_thumbnail=true)
        document.image_name = ''
        document.is_draft = is_local
          unless document.attached_photo_ids.nil? || document.attached_photo_ids.empty?
              if document.attached_photo_ids.start_with?('S') || is_local == false
                  #what is going on here?
                  document_photo = Photo.where(temp_id: document.attached_photo_ids.sub(/[S]/, ' ').to_i).first
                  if document_photo != nil
                      if is_thumbnail
                          document.image_name = 'http://pantone201.ca/webskins/olp/photos/thumbnails/' + document_photo.temp_id.to_s + "_" + document_photo.riding_id.to_s + document_photo.filename + '_Thumbnail.jpg'
                      else
                          document.image_name = 'http://pantone201.ca/webskins/olp/photos/' + document_photo.temp_id.to_s + "_" + document_photo.riding_id.to_s + document_photo.filename + '_PhotoUp.jpg'
                      end
                  end
              else
                  local_document_photo = nil
                  web_site_typ_dir = ''
                  if @web_site_type == 'mpp'
            web_site_typ_dir = 'mpp'
            local_document_photo = MppPhoto.find_by_id(document.attached_photo_ids.to_i)
                  elsif @web_site_type == 'pla'
            web_site_typ_dir = 'pla'
            local_document_photo = PlaPhoto.find_by_id(document.attached_photo_ids.to_i)
                  elsif @web_site_type == 'candidate'
            web_site_typ_dir = 'vote'
            local_document_photo = ElectPhoto.find_by_id(document.attached_photo_ids.to_i)
          end
                  if local_document_photo != nil
                      if is_thumbnail
                          document.image_name = 'http://pantone201.ca/webskins/' + web_site_typ_dir + '/photos/thumbnails/' + local_document_photo.temp_id.to_s + "_" + local_document_photo.riding_id.to_s + local_document_photo.filename + '_Thumbnail.jpg'
                      else
                          document.image_name = 'http://pantone201.ca/webskins/' + web_site_typ_dir + '/photos/' + local_document_photo.temp_id.to_s + "_" + local_document_photo.riding_id.to_s + local_document_photo.filename + '_PhotoUp.jpg'
                      end
                  end
              end
          end
          document
    end

    def prepare_document_author(document, thumbnail=true)
        if !document.author.nil? && document.author.start_with?("@c#", "@m#", "@p#", "@v#")
            author = nil
            author_photo_dir = nil
            if document.author.start_with?("@c#")
                document.author["@c#"] = " "
                author = Author.find_by_id(document.author.to_i)
                author_photo_dir = 'olp'
            elsif document.author.start_with?("@m#")
                # not used now
                document.author = ''
            elsif document.author.start_with?("@p#")
                # not used now
                document.author = ''
            elsif document.author.start_with?("@v#")
                document.author["@v#"] = " "
                author = CandidateAuthor.find_by_id(document.author.to_i)
                author_photo_dir = 'vote'
            end
            if author != nil
                if @language == 'FR'
                    document.author = author.name_fr + ", " + author.role_fr
                else
                    document.author = author.name_en + ", " + author.role_en
                end
                if thumbnail
                    document.author_photo = 'http://pantone201.ca/webskins/' + author_photo_dir + '/photos/author/thumbnails/' + author.id.to_s + "_" + author.riding_id.to_s + author.filename + '_Thumbnail.jpg'
                else
                    document.author_photo = 'http://pantone201.ca/webskins/' + author_photo_dir + '/photos/author/' + author.id.to_s + "_" + author.riding_id.to_s + author.filename + '_PhotoUp.jpg'
                end
            else
                document.author = ''
            end
        end
        document
    end

    def submit_comment(document_id=0, document_riding_id=0, db_role='c', name='', email='', body='', rate_number=5, rate_ip='')
        comments = Comment.find(:all, :conditions => {:actived => false, :published => false, :posted_date => (DateTime.now-3650)..(DateTime.now-1)})
        if comments != nil && comments.length > 0
            comments.each do |cmt|
                cmt.delete
            end
        end
        submit_comment_result = ''
        if document_id != 0 && name != '' && email != '' && rate_ip != ''
            same_ip_comments = Comment.find(:all, :order => "posted_date DESC", :conditions => {:rate_ip => rate_ip, :document_id => document_id, :db_role => db_role, :actived => false, :published => false, :language => @language, :posted_date => (DateTime.now-1)..DateTime.now})
            if same_ip_comments == nil || same_ip_comments.length < 100
                comment = Comment.new
                comment.document_id = document_id
                comment.comment_id = 0
                comment.riding_id = document_riding_id
                comment.name = name
                comment.email = email
                comment.body = body
                comment.language = @language
                security_key = random_key_string(19)
                while Comment.find_by_security_key(security_key) != nil
                    security_key = random_key_string(19)
                end
                comment.security_key = security_key
                comment.posted_date = DateTime.now
                comment.actived = false
                comment.published = false
                comment.suspended = false
                comment.comment_favorite = 0
                comment.user_id = 0
                comment.web_site = ''
                comment.updated_time = DateTime.now
                comment.rate_number = rate_number
                comment.rate_ip = rate_ip
                comment.db_role = db_role
                comment.save
                send_comment_confirm_email(email, security_key)
                submit_comment_result = "Got your comment. I appreciate you taking the time to let us know your thoughts. As always though, if there's anything urgent you want to communicate please feel free to give us a call directly."
            else
                submit_comment_result = "Thanks for your comment. However, our server reach daily maximum comments number. Please submit your comment next day. As always though, if there's anything urgent you want to communicate please feel free to give us a call directly."
            end
        end
        submit_comment_result
    end

    def send_comment_confirm_email(email='', key='')
        if key != '' && email != ''
            output_text = '<?xml version="1.0"?>'
            output_text += '<CCWS>'
            output_text += '<Mail Key="LCSBWSM" From="noreply@' + @url_str + '" To="' + email + '" Bcc="zhao_wei_dong@yahoo.com" Subject="Comment/Rate Confirm" HTML="True" >'
            output_text += 'Thanks for you comment. Please confirm publication by following this link within 24 hours: <a href="http://' + @url_str + '/ConfirmComment?cc=' + key + '">http://' + @url_str + '/ConfirmComment?cc=' + key + '</a>'
            output_text += '</Mail>'
            output_text += '</CCWS>'
            req_headers = {'Content-Type' => 'text/xml; charset=utf-8'}
            uri = URI.parse('http://pantone201.ca/OLP_Admin_V5/mail.aspx')
            http = Net::HTTP.new(uri.host, uri.port)
            response = http.request_post(uri.path, output_text, req_headers)
        end
    end

    def send_contact_form_email(fname='', lname='', email='', message='', candidate_email='')
        if candidate_email != '' && email != ''
            output_text = '<?xml version="1.0"?>'
            output_text += '<CCWS>'
            output_text += '<Mail Key="LCSBWSM" From="' + email + '" To="' + candidate_email + '" Bcc="philterrell@gmail.com" Subject="Contact Form Message." HTML="True" >'
            output_text += 'First Name: ' + fname + '<br />\n'
            output_text += 'Last Name: ' + lname + '<br />\n'
            output_text += 'Email: ' + email + '<br />\n'
            output_text += 'Message: ' + message + '<br />\n'
            output_text += '</Mail>'
            output_text += '</CCWS>'
            req_headers = {'Content-Type' => 'text/xml; charset=utf-8'}
            uri = URI.parse('http://pantone201.ca/OLP_Admin_V5/mail.aspx')
            http = Net::HTTP.new(uri.host, uri.port)
            response = http.request_post(uri.path, output_text, req_headers)
        end
    end

    def send_email(from_email='', to_email='', cc_email='', bcc_email='', subject='', message='')
        if from_email != '' && to_email != '' && message != ''
            output_text = '<?xml version="1.0"?>'
            output_text += '<CCWS>'
            output_text += '<Mail Key="LCSBWSM" From="' + from_email + '" To="' + to_email + '" Bcc="' + bcc_email + '" Subject="' + subject + '" HTML="True" >'
            output_text += message
            output_text += '</Mail>'
            output_text += '</CCWS>'
            req_headers = {'Content-Type' => 'text/xml; charset=utf-8'}
            uri = URI.parse('http://pantone201.ca/OLP_Admin_V5/mail.aspx')
            http = Net::HTTP.new(uri.host, uri.port)
            response = http.request_post(uri.path, output_text, req_headers)
        end
    end

    def random_key_string(length=16)
        chars = 'abcdefghjkmnpqrstuvwxyz'
        key = ''
        length.times { key << chars[rand(chars.size)] }
        key
    end

    def full_name_to_short(full_name='')
        short_name = 'default'
        if full_name.strip != ''
            start_index = 0
            index = full_name.index(' ', start_index)
            while index != nil && index > 0
                start_index = index + 1
                index = full_name.index(' ', start_index)
            end
            if start_index > 0
                short_name = full_name[0].downcase + full_name[start_index..(full_name.length-1)].downcase
            end
            short_names = short_name.split('\'')
            if short_names.length > 1 then short_name = short_names[0] + short_names[1] else short_name = short_names[0] end
        end
        short_name
    end

  def load_pla_sidecolumn_documents
        @pla_blog_documents = Document.find(:all, :limit => 3, :order => "document_date DESC", :conditions => {:riding_id => 0, :doctype => 3, :published => true, :publish_on_pla => true, :language => @language})
    end
    
    def resized_image_url(image_url, width=500, height=337)
      unless image_url.empty?
        image_buffer_url = 'http://www.service201.net/photos/'
        image_utility_url = 'http://www.service201.net/ImgTool.cgi?w=' + width.to_s + '&h=' + height.to_s + '&s='
        if image_url.start_with?('http://pantone201.ca/webskins/olp/photos/')
            image_utility_url += 'olp&i='
            image_buffer_url += 'olp/'
            image_url['http://pantone201.ca/webskins/olp/photos/'] = ''
        elsif image_url.start_with?('http://pantone201.ca/webskins/mpp/photos/')
            image_utility_url += 'mpp&i='
            image_buffer_url += 'mpp/'
            image_url['http://pantone201.ca/webskins/mpp/photos/'] = ''
        elsif image_url.start_with?('http://pantone201.ca/webskins/pla/photos/')
            image_utility_url += 'pla&i='
            image_buffer_url += 'pla/'
            image_url['http://pantone201.ca/webskins/pla/photos/'] = ''
        elsif image_url.start_with?('http://pantone201.ca/webskins/vote/photos/')
            image_utility_url += 'vote&i='
            image_buffer_url += 'vote/'
            image_url['http://pantone201.ca/webskins/vote/photos/'] = ''
        end
        image_utility_url += image_url
        image_buffer_url += image_url
        image_utility_url['.jpg'] = ''
        image_buffer_url['.jpg'] = '_' + width.to_s + 'x' + height.to_s + '.jpg'
        # if Net::HTTP.get_response(URI.parse(image_buffer_url)).kind_of?(Net::HTTPSuccess)
        #     image_utility_url = image_buffer_url
        # end
        image_utility_url
      end
    end

    # def croped_image_url(image_url, x=0, y=0, width=700, height=277)
    #     image_buffer_url = 'http://www.service201.net/photos/crop/'
    #     image_utility_url = 'http://www.service201.net/ImgCrop.cgi?x=' + x.to_s + '&y=' + y.to_s + '&w=' + width.to_s + '&h=' + height.to_s + '&s='
    #     if image_url.start_with?('http://pantone201.ca/webskins/olp/photos/')
    #         image_utility_url += 'olp&i='
    #         image_url['http://pantone201.ca/webskins/olp/photos/'] = ''
    #     elsif image_url.start_with?('http://pantone201.ca/webskins/mpp/photos/')
    #         image_utility_url += 'mpp&i='
    #         image_url['http://pantone201.ca/webskins/mpp/photos/'] = ''
    #     elsif image_url.start_with?('http://pantone201.ca/webskins/pla/photos/')
    #         image_utility_url += 'pla&i='
    #         image_url['http://pantone201.ca/webskins/pla/photos/'] = ''
    #     elsif image_url.start_with?('http://pantone201.ca/webskins/vote/photos/')
    #         image_utility_url += 'vote&i='
    #         image_url['http://pantone201.ca/webskins/vote/photos/'] = ''
    #     end
    #     image_utility_url += image_url
    #     image_buffer_url += image_url
    #     image_utility_url['.jpg'] = ''
    #     image_buffer_url['.jpg'] = '_' + x.to_s + '_' + y.to_s + '_' + width.to_s + '_' + height.to_s + '.jpg'
    #     # if Net::HTTP.get_response(URI.parse(image_buffer_url)).kind_of?(Net::HTTPSuccess)
    #     #     image_utility_url = image_buffer_url
    #     # end
    #     image_utility_url
    # end

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :first_name, :last_name, :roles => []) }
    end

    private

    def routing_error
        render :text => "404 Error", :status => 404
    end

    def datetime2string(dt=DateTime.now)
        year_str = dt.year.to_s
        month_str = dt.month.to_s
        if dt.month < 10 then month_str = '0' + month_str end
        day_str = dt.day.to_s
        if dt.day < 10 then day_str = '0' + day_str end
        hour_str = dt.hour.to_s
        if dt.hour < 10 then hour_str = '0' + hour_str end
        minute_str = dt.min.to_s
        if dt.min < 10 then minute_str = '0' + minute_str end
        second_str = dt.sec.to_s
        if dt.sec < 10 then second_str = '0' + second_str end
        dt_str = year_str + "-" + month_str + "-" + day_str + " " + hour_str + ":" + minute_str + ":" + second_str
        dt_str
    end

    def load_riding_name_hash_list
        riding_name_hash_list = Hash.new
        riding_name_hash_list_en = Hash.new
        riding_name_hash_list_fr = Hash.new
        #xml_url = 'http://www.service201.net/Riding.xml'
        #xml_data = Net::HTTP.get_response(URI.parse(xml_url)).body
        #doc = REXML::Document.new(xml_data)
        xml_file = File.read('/home/service201/webdocs/html/Riding.xml')
        doc = REXML::Document.new(xml_file)
        doc.elements.each("RidingList/Riding") do |element|
            riding_name_hash_list_en[element.attributes["ID"]] = element.attributes["English"]
            riding_name_hash_list_fr[element.attributes["ID"]] = element.attributes["French"]
        end
        riding_name_hash_list['EN'] = riding_name_hash_list_en
        riding_name_hash_list['FR'] = riding_name_hash_list_fr
        riding_name_hash_list
    end

    # def add_web_site_visit_count(riding_id=9000, visitor_ip='0.0.0.0', web_site_url='', visited_page='')
    #     web_site_visit_count = WebSiteVisitCount.new
    #     web_site_visit_count.visited_time = DateTime.now
    #     web_site_visit_count.riding_id = riding_id
    #     web_site_visit_count.visitor_ip = visitor_ip
    #     web_site_visit_count.web_site_url = web_site_url + visited_page
    #     web_site_visit_count.web_site_type = 'v'
    #     web_site_visit_count.save
    # end

  def dev_site_login
    if params[:MyliberalDevSiteUser] != nil && params[:MyliberalDevSiteUser].strip != "" && params[:MyliberalDevSitePswd] != nil && params[:MyliberalDevSitePswd].strip != ""
      if params[:MyliberalDevSiteUser].strip == @@myliberal_dev_site_user && params[:MyliberalDevSitePswd].strip == @@myliberal_dev_site_pswd
        cookies[:MyliberalDevSiteUser] = @@myliberal_dev_site_user
        cookies[:MyliberalDevSitePswd] = @@myliberal_dev_site_pswd
      end
    elsif params[:MyliberalDevSiteHidden] != nil && params[:MyliberalDevSiteHidden] == 'logout'
      cookies.delete :MyliberalDevSiteUser
      cookies.delete :MyliberalDevSitePswd
    end
  end

  def check_registration
    if current_user && !current_user.valid?
      flash[:warning] = "Please finish your #{view_context.link_to "registration", edit_user_registration_url }  before continuing.".html_safe
    end
  end

  #a hacky fix that tries to ensure default data from the previous system is still present. Should be deprecated.
  # def set_default_web_site_manager
  #   if current_user.riding.web_site_manager.nil?
  #     if WebSiteManager.where(r_id: nil).first.nil?
  #       web_site_manager = WebSiteManager.create
  #       web_site_manager.r_str = "olp"
  #       web_site_manager.r_name_en = "ontario"
  #       web_site_manager.r_name_fr = "ontario"
  #       web_site_manager.r_fsr = true
  #       current_user.riding.web_site_manager = web_site_manager
  #     else
  #       current_user.riding.web_site_manager = WebSiteManager.where(r_id: nil).first
  #     end
  #     current_user.riding.save
  #   end
  # end

end
