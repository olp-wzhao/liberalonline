class EventsController < ApplicationController
    before_filter :authenticate_user!, :only => [:create, :update, :destroy]

    respond_to :html, :json

    def index
		  @event_documents = Event.where(:doc_type => 0, :language => @language, :published => true)
                            .gt(event_datetime: DateTime.now)
                            .order_by(:event_datetime.desc)
    end

    def show
    end

    def update
      respond_to do |format|
        if @event.update(event_params)
          format.html { redirect_to @event, notice: 'Transaction was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render json: 'event updated successfully', status: :updated }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end 
      end
    end

    def new
    end

    def create
      success = false
      @event = Event.where(temp_id: event_params["temp_id"])
      if(@event.any?)
        @event = @event.first
        success = @event.update(event_params)
      else
        @event = Event.new(event_params)  
        succss = @event.save
      end
      
      respond_to do |format|
        if success
          format.json { render json: 'event saved successfully', status: :created }
        else
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end
    
    def event_params
      params.require(:event).permit(:auth_token, :title, :event_datetime, :location, :address, :address_hint, :email, :contact_person, :phone_number, :summary, :require_register, :member_only, :style, :attached_photo_ids, :attached_video_ids, :attached_pdf_ids, :created_date, :created_ip, :created_user_id, :updated_ip, :language, :doc_type, :feature_level, :ticket_for_sell, :ticket_price_single, :ticket_price_pair, :ticket_price_table, :ticket_price_abc, :ticket_price_red_trillium, :ticket_price_youth, :ticket_price_senior, :ticket_price_observer, :ticket_price_free, :ticket_price_other, :ticket_price_option, :published, :display_date, :expiry_date, :publish_on_olp, :publish_on_mpp, :publish_on_pla,
        :publish_on_elect, :partisan, :temp_id, :riding_id, :web_site, :updated_time)
    end
end
