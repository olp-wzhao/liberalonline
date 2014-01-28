class PhotosController < ApplicationController

	layout "inside_layout"

	def index
	  
		@paginate_size = 30
		#@photos = Photo.find(:all, :limit => 99, :order => "created_date DESC", :conditions => {:riding_id => 0, :published => true})
		
		@photos = Photo.where({riding_id: 0, published: true})
						.order_by(:created_date.desc)
						.page(params[:page].nil? ? 0 : params[:page])
						.per(@paginate_size)
		if @photos != nil && @photos.length > 0
			@photos.each do |photo|
				if photo.caption_en == nil || photo.caption_en.strip == '' then photo.caption_en = 'Visit OntarioLiberal.ca for more' end
				if photo.caption_fr == nil || photo.caption_fr.strip == '' then photo.caption_fr = 'Visit OntarioLiberal.ca for more' end
			end
		end
	end

	private

		def photo_params
			params.require(:photo).permit(:temp_id)
		end
end
