class VideosController < ApplicationController

	layout "inside_layout"

	def index
		@videos = Video.where(:riding_id => 0, :published => true, language: @language)
                      .order_by(:created_date.desc) #, :language => @language
    end

	def show
		@other_videos = Video.where(:riding_id => 0, :published => true, language: @language)
                      .order_by(:created_date.desc) #, :language => @language
    	@other_videos.each do |other_video|
    		if other_video.id.to_s.eql?(params[:id].to_s)
	        	@video = other_video
        	end
        end
    end

end
