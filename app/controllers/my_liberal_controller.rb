class MyLiberalController < ApplicationController
    before_filter :authenticate_user!
    #layout "inside_layout"

    def index
    		@bites_documents = nil
    		@local_mpp_documents = nil
    		@local_pla_documents = nil
    		@local_candidate_documents = nil
        @olp_passport_user_web_site_manager = nil

  		if current_user
        binding.pry
        #check if there is a web_site_manager attached
        if current_user.riding.web_site_manager == nil
          current_user.riding.web_site_manager = WebSiteManager.find_by(r_id: (current_user.riding.riding_id + 9000) )
        end

  			# already login
        # this was removed from the query :riding_id => -6..0,
  			@bites_documents = Document.where({ :doc_type => 17, :published => true, :language => @language, :expiry_date => DateTime.now..(DateTime.now+3650)})
                          .limit(3)
                          .order_by(:document_date.desc)
  			@bites_documents.each do |document|
  				document = prepare_document_photo(document, false)
  			end
  			@local_mpp_documents = MppDocument.where({:riding_id => current_user.riding.riding_id, :published => true, :language => @language})
                .gt(expiry_date: DateTime.now) 
                .between(document_date: (DateTime.now-30)..DateTime.now)
                .between(doc_type: 0..1)
                .limit(99)
                .order_by(:document_date.desc)
  			@local_pla_documents = PlaDocument.where({:riding_id => current_user.riding.riding_id, :published => true, :language => @language})
                .gt(expiry_date: DateTime.now) 
                .between(document_date: (DateTime.now-365)..DateTime.now)
                .between(doc_type: 0..1)
                .limit(99)
                .order_by(:document_date.desc)
        @local_candidate_documents = Document.where({:riding_id => current_user.riding.riding_id, :published => true, :language => @language})
                .gt(expiry_date: DateTime.now)
                .between(document_date: (DateTime.now-365)..DateTime.now)
                .between(doc_type: 0..1)
                .limit(99)
                .order_by(:document_date.desc)
        #@local_mpp_documents = MppDocument.find(:all, :limit => 99, :order => "document_date DESC", :conditions => {:riding_id => @olp_passport_user.riding_id, :doc_type => (0..1), :published => true, :language => @language, :expiry_date => DateTime.now..(DateTime.now+3650)})
  			#@local_pla_documents = PlaDocument.find(:all, :limit => 99, :order => "document_date DESC", :conditions => {:riding_id => @olp_passport_user.riding_id, :doc_type => (0..1), :published => true, :language => @language, :expiry_date => DateTime.now..(DateTime.now+3650)})
  			#@local_candidate_documents = Document.find(:all, :limit => 99, :order => "document_date DESC", :conditions => {:riding_id => @olp_passport_user.riding_id, :doc_type => (0..1), :published => true, :language => @language, :expiry_date => DateTime.now..(DateTime.now+3650)})
  			#@olp_passport_user_web_site_manager = WebSiteManager.find_by_id(@current_user.riding.riding_id)
  		else
  			redirect_to new_user_session_url
  		end
    end

end
