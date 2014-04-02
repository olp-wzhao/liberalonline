class HomeController < ApplicationController
  #before_filter :authenticate_user!

    def index

        @top_feature_rotator_document = nil
        @rotators = Array.new
        # Get Central Rotator if No Riding Rotator Available
        if @all_language_rotators == nil || @all_language_rotators.length == 0 || @rotators.length == 0
            @all_language_rotators = Rotator.where(riding_id: 0)
                                            .order_by(:is_local_published.desc)
            # remove diffirent language documents
            @all_language_rotators.each do |rotator|
                rotator_document = nil
                if rotator.database_name == 'cdb' then rotator_document = Document.where(temp_id: rotator.document_id).first end
                # Add equal nil condition in case the document was delete after add to rotator
                if rotator_document != nil && rotator_document.language.strip.upcase == @language.strip.upcase then @rotators << rotator end
            end
        end
        # set first rotators document as top feature document in case no top feature document has been set
        if @rotators != nil && @rotators.length > 0
            if @rotators[0].database_name == 'cdb' then @top_feature_rotator_document = Document.where(temp_id: @rotators[0].document_id).first end
        end

		@mobile_rotator_documents = Array.new
        @rotator_documents = Array.new
        @rotators.each do |rotator|
            if rotator.database_name == 'cdb'
                rotator_document = Document.where(temp_id: rotator.document_id).first
                if rotator_document != nil
                    rotator_document = prepare_document_photo(rotator_document, false, false)
                    #@mobile_rotator_documents << rotator_document.clone
                    @rotator_documents << rotator_document
                    if rotator.is_local_published
                        @top_feature_rotator_document = rotator_document
                    end
                end
            end
        end
        @rotator_js = ''
        if @rotator_documents != nil && @rotator_documents.length > 0
            @rotator_js = "<script language=\"javascript\">\n"
            @rotator_js += "var photos = [\n"
            for i in 1..@rotator_documents.length
                if i != 1 then @rotator_js += "," end
                @rotator_js += "{\n"
                feature_type = 'News'
                if @rotator_documents[i-1].doc_type == 0
                    #feature_type = 'Press Release'
                elsif @rotator_documents[i-1].doc_type == 1
                    #feature_type = 'News Clip'
                elsif @rotator_documents[i-1].doc_type == 2
                    #feature_type = 'Provincial Feature MPP'
                elsif @rotator_documents[i-1].doc_type == 3
                    feature_type = 'Blog'
                elsif @rotator_documents[i-1].doc_type == 4
                    feature_type = 'Issue'
                elsif @rotator_documents[i-1].doc_type == 5
                    #feature_type = 'OLP Feature Alert'
                elsif @rotator_documents[i-1].doc_type == 6
                    #feature_type = 'Need Help'
                elsif @rotator_documents[i-1].doc_type == 7
                    feature_type = 'Progress'
                end
                @rotator_js += "\"title\" : \"" + feature_type + "\",\n"
                @rotator_js += "\"image\" : \"" + resized_image_url(@rotator_documents[i-1].image_name) + "\",\n"
                @rotator_js += "\"url\"   : \"/News/" + @rotator_documents[i-1].id.to_s + "\",\n"
                @rotator_js += "\"firstline\" : \"" + @rotator_documents[i-1].headline + "\",\n"
                @rotator_js += "\"secondline\" : \" \"\n"
                @rotator_js += "}"
            end
            @rotator_js += "];\n"
            @rotator_js += "</script>\n"

            # update facebook favourite information
            #@web_site_title = @rotator_documents[0].headline
            @web_site_og_title = @rotator_documents[0].headline
            @web_site_og_site_name = @rotator_documents[0].headline
            @web_site_og_description = @rotator_documents[0].headline
            #if @current_document.image_name != nil && @current_document.image_name != ''
            #    @web_site_og_image = @rotator_documents[0].image_name
            #end
            #@web_site_og_url = 'http://' + @candidate_domain + '/News/' + @current_document.id.to_s + '?l=' + @language
        end

        @mobile_rotator_documents.each do |document|
            document = prepare_document_photo(document, false)
        end
        
        @all_picture_news_documents = Document.where(riding_id: 0, published: true, publish_on_pla: true, language: @language)
                                                .between(doc_type: 0..1)
                                                .gt(expiry_date: DateTime.now)
                                                .order_by(:document_date.desc) 
        picture_news_documents_size = 0
        @picture_news_documents = Array.new
        @all_picture_news_documents.each do |document|
			if document.attached_photo_ids != nil && document.attached_photo_ids != '' && picture_news_documents_size < 3
				@picture_news_documents << document
				picture_news_documents_size += 1
			end
        end
        @picture_news_documents.each do |document|
            document = prepare_document_photo(document, false)
        end
		
		@photos = Photo.where({riding_id: 0, published: true})
						.order_by(:created_date.desc)
						.limit(3)
						
        @featured_videos = PlaVideo.where(:riding_id => riding_id, :is_featured_video => true, :language => @language, :published => true)
                                    .order_by(:created_date.desc)       
    end
end
