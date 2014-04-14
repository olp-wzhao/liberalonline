class CandidatesController < ApplicationController

    layout "inside_layout"

    def index

    	#@web_site_managers = WebSiteManager.gt(expiry_date: DateTime.now).order_by(:r_id.asc)
        @candidates = Candidate.all
        #@web_site_managers.each do |web_site_manager|
       #  Canditate.all.each do |candidate|
    			# #candidate_infos = Candidate.where(:riding_id => web_site_manager.r_id)
    			# if candidate_infos.length > 0
    			# 	web_site_manager.c_nm = ((CGI.unescapeHTML(candidate.biography_partisan_en.downcase)).split('<', 2)[0]).strip
    			# 	web_site_manager.c_fpes = candidate.published
    			# 	#web_site_manager.c_nm = web_site_manager.c_nm[3, web_site_manager.c_nm.length]
    			# 	#web_site_manager.c_nm = CGI.unescapeHTML(candidate_infos[0].biography_non_partisan_en)
    			# end
       #  end
    end

end
