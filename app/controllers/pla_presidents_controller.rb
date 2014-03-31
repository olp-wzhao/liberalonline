class PlaPresidentsController < ApplicationController

    layout "inside_layout"

    def index

		@riding_executives = RidingExecutive.where(:role_code => 0)
											.order_by(:riding_id.asc)
		@riding_executives_hash = Hash.new
		@riding_executives.each do |riding_executive|
			@riding_executives_hash[riding_executive.riding_id] = riding_executive
		end
		@web_site_managers = WebSiteManager.order_by(:r_id.asc)
    end

end
