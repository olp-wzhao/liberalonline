class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session
  #before_filter :check_registration
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :load_application_action, :load_application_layout, :most_recent_event

  layout :layout_by_resource

  def layout_by_resource
    if devise_controller? && resource_name == :admin
      'admin'
    else
      'application'
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

      #@is_facebook_user_login = false;
      #@fu_id = cookies[:fu_id]
      #@fu_name = cookies[:fu_name]
      #@fu_gender = cookies[:fu_gender]
      #@fu_bio = cookies[:fu_bio]
      #if @fu_id != nil && @fu_id != ''
      #  @is_facebook_user_login = true;
      #end
          
      @olp_user = nil
      if cookies[:OlpUserKey] != nil && cookies[:OlpUserKey] != ''
        @olp_user = OlpUser.find_by_security_key(cookies[:OlpUserKey].to_s)
      end
    end
  end

  def riding_id
    riding = 9000
    unless current_user.nil?
      unless current_user.riding.nil?
        riding = current_user.riding.riding_id - 9000
      end
    end
    riding
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

    def random_key_string(length=16)
        chars = 'abcdefghjkmnpqrstuvwxyz'
        key = ''
        length.times { key << chars[rand(chars.size)] }
        key
    end

    #def full_name_to_short(full_name='')
    #    short_name = 'default'
    #    if full_name.strip != ''
    #        start_index = 0
    #        index = full_name.index(' ', start_index)
    #        while index != nil && index > 0
    #            start_index = index + 1
    #            index = full_name.index(' ', start_index)
    #        end
    #        if start_index > 0
    #            short_name = full_name[0].downcase + full_name[start_index..(full_name.length-1)].downcase
    #        end
    #        short_names = short_name.split('\'')
    #        if short_names.length > 1 then short_name = short_names[0] + short_names[1] else short_name = short_names[0] end
    #    end
    #    short_name
    #end

  def load_pla_sidecolumn_documents
        @pla_blog_documents = Document.find(:all, :limit => 3, :order => "document_date DESC", :conditions => {:riding_id => 0, :doc_type => 3, :published => true, :publish_on_pla => true, :language => @language})
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
        #if Net::HTTP.get_response(URI.parse(image_buffer_url)).kind_of?(Net::HTTPSuccess)
        #    image_utility_url = image_buffer_url
        #end
        image_utility_url
      end
    end

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :first_name, :last_name, :roles => []) }
    end

    private

    def routing_error
        render :text => "404 Error", :status => 404
    end

  def check_registration
    if current_user && !current_user.valid?
      flash[:warning] = "Please finish your #{view_context.link_to "registration", edit_user_registration_url }  before continuing.".html_safe
    end
  end

end
