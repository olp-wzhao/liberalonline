class Api::V1::EventController < ApiController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.json { render json: @event, status: :success }
      else
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
      success = @event.save
    end

    respond_to do |format|
      if success
        format.json { render json: @event, status: :created }
      else
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

end