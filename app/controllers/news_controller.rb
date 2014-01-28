class NewsController < ApplicationController

    layout "inside_layout"

    def index
        @paginate_size = 10
        #@news_documents = Document.find(:all, :limit => 99, :order => "document_date DESC", :conditions => {:riding_id => (-6..0), :doctype => (0..1), :published => true, :language => @language, :expiry_date => DateTime.now..(DateTime.now+3650)})
		@news_documents = Document
							.page(params[:page])
							.per(@paginate_size)
							.order_by(:document_date.desc)
							.between(riding_id: -6..0, doctype: 0..1)
							.gt(expiry_date: DateTime.now)
							.where(:published => true, :language => @language)
    end

    def show

		@current_document = nil
		
		begin
			@current_documents = Document.where(id: params[:id], published: true, language: @language)
											.between(riding_id: -6..0)
											.gt(expiry_date: DateTime.now)
											.order_by(:id.desc)
			@current_document = @current_documents[0]
		rescue ActiveRecord::RecordNotFound
			redirect_to '/news?l=' + @language
		end

		if @current_document == nil
			redirect_to '/error'
		else
			@current_document_photo = nil
			if @current_document.attached_photo_ids != nil && @current_document.attached_photo_ids != "" && @current_document.attached_photo_ids != "0"
				@current_document_photo = Photo.where(temp_id: @current_document.attached_photo_ids.sub(/[S]/, ' ').to_i).first
			end
			@current_document_attachments = nil
			if @current_document.attached_pdf_ids != nil && @current_document.attached_pdf_ids != ""
				attachment_ids_str = @current_document.attached_pdf_ids.split('|')
				if attachment_ids_str != nil && attachment_ids_str.length > 0
					@current_document_attachments = Array.new
					attachment_ids_str.each do |attachment_id_str|
						document_attachment = Attachment.find_by_id(attachment_id_str.to_i)
						if document_attachment != nil
							@current_document_attachments << document_attachment
						end
					end
				end
			end
		end 

		@web_site_og_description = @current_document.subtitle
		@web_site_og_title = @current_document.headline
		if @current_document_photo 
		    @web_site_og_image = 'http://pantone201.ca/webskins/olp/photos/' + @current_document_photo.id.to_s + "_" + @current_document_photo.riding_id.to_s + @current_document_photo.filename + '_PhotoUp.jpg'
		else
			@web_site_og_image = 'http://www.ontarioliberal.ca/NewsBlog/media/Wynne_Headshot_Link.jpg'
		end	
		
    end

end
