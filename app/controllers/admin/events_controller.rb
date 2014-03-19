class Admin::EventsController < Admin::AdminController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all.limit(10)
  end

  def new
    @event = Event.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /events
  # POST /events.json
  def create
    success = false
    # API calls need to use temp_id, perhaps they should be in an API controller
    @event = Event.where(id: document_params['id']).first
    if !@event.nil?
      success = @event.update(document_params)
    else
      @event = Document.new(document_params)
      success = @event.save
    end

    respond_to do |format|
      if success
        format.html { redirect_to admin_events_path, notice: 'Event was successfully created.' }
        format.json { render json: 'event saved to mongodb', status: :created }
        format.js
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end
  
  def edit
    respond_to do |format|
      format.js
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to admin_events_url, notice: 'Document was successfully updated.' }
        format.json { head :no_content, status: :success }
        format.js
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to admin_events_url }
      format.json { head :no_content }
      format.js
    end
  end
  
  def set_event
    @event = Event.find params[:id]
  end

  private
  def event_params
    params.require(:event).permit(
        :title,
        :event_datetime,
        :location, 
        :address,
        :address_hint,
        :email,
        :contact_person,
        :phone_number,
    :summary,
    :require_register, 
    :member_only, 
    :style, 
    :created_ip, 
    :updated_ip, 
    :language, 
    :doc_type, 
    :feature_level, 
    :ticket_for_sell, 
    :ticket_price_single, 
    :ticket_price_pair, 
    :ticket_price_table, 
    :ticket_price_abc, 
    :ticket_price_red_trillium, 
    :ticket_price_youth, 
    :ticket_price_senior, 
    :ticket_price_observer, 
    :ticket_price_free, 
    :ticket_price_other, 
    :ticket_price_option, 
    :published, 
    :display_date, 
    :expiry_date, 
    :publish_on_olp, 
    :publish_on_mpp, 
    :publish_on_pla, 
    :publish_on_elect, 
    :partisan, 
    :web_site, 
    :updated_time, 
    :temp_id

    )
  end

end