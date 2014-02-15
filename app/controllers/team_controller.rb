class TeamController < ApplicationController

    layout "inside_layout"

    def index
        load_application_action
        load_application_layout
    end

	def show
        load_application_action
        load_application_layout
	end

end
