class EventsController < ApplicationController

    layout "inside_layout"

    def index

		@event_documents = Event.where(:doc_type => 0, :language => @language, :published => true)
                            .gt(event_datetime: DateTime.now)
                            .order_by(:event_datetime.desc)
    end

    def show
    end

end
