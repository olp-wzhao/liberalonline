class Admin::AdminController < ActionController::Base
  layout 'admin'
  before_filter :authenticate_admin!

  #this is supposed to handle csrf token errors
  def verified_request?
    if request.content_type == "application/json"
      true
    else
      super()
    end
  end
end