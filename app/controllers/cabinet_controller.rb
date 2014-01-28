class CabinetController < ApplicationController

    layout "inside_layout"

    def index
        @cabinet_mpps = MppInfo.where(:is_cabinet_minister => true, :published => true).order_by(:temp_id.desc)
    end

end
