class MppsController < ApplicationController

    layout "inside_layout"

    def index        
    	@web_site_managers = WebSiteManager.gt(:expiry_date => DateTime.now).order_by(:order => "r_id")
        @web_site_managers.each do |web_site_manager|
			mpp_infos = MppInfo.where(:riding_id => web_site_manager.r_id - 9000)
			if mpp_infos.count > 0
				#web_site_manager.m_nm = ((CGI.unescapeHTML(mpp_infos[0].biography_non_partisan_en.downcase)).split('</', 2)[0]).strip
				#web_site_manager.m_nm = web_site_manager.m_nm[3, web_site_manager.m_nm.length]
				web_site_manager.m_nm = CGI.unescapeHTML(mpp_infos[0].biography_introduction_partisan_en)
			end
        end
    end

    def show
		@mpp_info = MppInfo.where(:riding_id => params[:id].to_i - 9000).first
		
		if @mpp_info.nil?
			redirect_to :controller => 'mpps'
		end
    end

end
