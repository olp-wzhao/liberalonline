module NewsExtras
  def prepare_news_documents
    news_documents = Document.news_documents.where(language: @language)
    news_documents.each do |document|
      document.photo = prepare_document_photo(document, false)
    end
    news_documents
  end
  
  def prepare_menu_photo
  	photo = nil 
  	photos = Photo.where({riding_id: 0, published: true}).order_by(:created_date.desc)
	if photos != nil && photos.length > 0 then photo = photos[0] end 
	photo 
  end 
  
  def prepare_menu_video
  	video = nil 
  	videos = Video.where(:riding_id => 0, :published => true, language: @language).order_by(:created_date.desc)
	if videos != nil && videos.length > 0 then video = videos[0] end 
	video
  end
  
  def prepare_menu_event_document
  	event_document = nil 
	event_documents = Event.where(:doc_type => 0, :language => @language, :published => true).gt(event_datetime: DateTime.now-100).order_by(:feature_level.desc, :event_datetime.desc)
	if event_documents != nil && event_documents.length > 0 then event_document = event_documents[0] end
	event_document
  end 

  def prepare_document_photo(document, is_local, is_thumbnail=true)
    document.image_name = ''
    document.is_draft = is_local
    unless document.attached_photo_ids.nil? || document.attached_photo_ids.empty?
      if document.attached_photo_ids.start_with?('S') || is_local == false
        #what is going on here?
        #document_photo = Photo.where(temp_id: document.attached_photo_ids.sub(/[S]/, ' ').to_i).first
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

  def load_sidecolumn_documents
    # Get all the central issue documents
    @sidecolumn_issue_documents = nil
    @sidecolumn_accomplishment_documents = nil
    if @web_site_type == 'mpp'
      @sidecolumn_accomplishment_documents = Document.mpp.where(doc_type: 7, language: @language)
    elsif @web_site_type == 'pla'
      @sidecolumn_accomplishment_documents = Document.pla.where(doc_type: 7, language: @language)
    else
      @sidecolumn_accomplishment_documents = Document.elect.where(doc_type: 7, language: @language)
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
        sidecolumn_local_accomplishment_documents = MppDocument.where(:riding_id => @web_site_manager.r_id - 9000, :doc_type => 7, :published => true, :language => @language)
        .order_by(:document_date.desc)
      elsif @web_site_type == 'pla'
        sidecolumn_local_accomplishment_documents = PlaDocument.where(:riding_id => @web_site_manager.r_id - 9000, :doc_type => 7, :published => true, :language => @language)
        .order_by(:document_date.desc)
      else
        sidecolumn_local_accomplishment_documents = ElectDocument.where(:riding_id => @web_site_manager.r_id - 9000, :doc_type => 7, :published => true, :language => @language)
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
      @sidecolumn_news_documents = Document.mpp #find(:all, :order => "document_date DESC", :conditions => {:riding_id => 0, :doc_type => 0..1, :published => true, :publish_on_mpp => true, :language => @language})
    elsif @web_site_type == 'pla'
      @sidecolumn_news_documents = Document.pla #find(:all, :order => "document_date DESC", :conditions => {:riding_id => 0, :doc_type => 0..1, :published => true, :publish_on_pla => true, :language => @language})
    else
      @sidecolumn_news_documents = Document.find(:all, :order => "document_date DESC", :conditions => {:riding_id => 0, :doc_type => 0..1, :published => true, :publish_on_elect => true, :language => @language})
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
        sidecolumn_local_news_documents = MppDocument.find(:all, :order => "document_date DESC", :conditions => {:riding_id => @web_site_manager.r_id - 9000, :doc_type => 0..1, :published => true, :language => @language})
      elsif @web_site_type == 'pla'
        sidecolumn_local_news_documents = PlaDocument.find(:all, :order => "document_date DESC", :conditions => {:riding_id => @web_site_manager.r_id - 9000, :doc_type => 0..1, :published => true, :language => @language})
      else
        sidecolumn_local_news_documents = ElectDocument.find(:all, :order => "document_date DESC", :conditions => {:riding_id => @web_site_manager.r_id - 9000, :doc_type => 0..1, :published => true, :language => @language})
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
      @sidecolumn_blog_documents = Document.find(:all, :order => "document_date DESC", :conditions => {:riding_id => 0, :doc_type => 3, :published => true, :publish_on_mpp => true, :language => @language})
    elsif @web_site_type == 'pla'
      @sidecolumn_blog_documents = Document.find(:all, :order => "document_date DESC", :conditions => {:riding_id => 0, :doc_type => 3, :published => true, :publish_on_pla => true, :language => @language})
    else
      @sidecolumn_blog_documents = Document.find(:all, :order => "document_date DESC", :conditions => {:riding_id => 0, :doc_type => 3, :published => true, :publish_on_elect => true, :language => @language})
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
        sidecolumn_local_blog_documents = MppDocument.find(:all, :order => "document_date DESC", :conditions => {:riding_id => @web_site_manager.r_id - 9000, :doc_type => 3, :published => true, :language => @language})
      elsif @web_site_type == 'pla'
        sidecolumn_local_blog_documents = PlaDocument.find(:all, :order => "document_date DESC", :conditions => {:riding_id => @web_site_manager.r_id - 9000, :doc_type => 3, :published => true, :language => @language})
      else
        sidecolumn_local_blog_documents = ElectDocument.find(:all, :order => "document_date DESC", :conditions => {:riding_id => @web_site_manager.r_id - 9000, :doc_type => 3, :published => true, :language => @language})
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
end