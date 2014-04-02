class Admin::AdminController < ActionController::Base
  layout 'admin'
  before_filter :authenticate_admin!, :log_stuff
  after_filter  :prepare_unobtrusive_flash

  #this is supposed to handle csrf token errors
  def verified_request?
    if request.content_type == "application/json"
      true
    else
      super()
    end
  end

  def log_stuff
    if !current_user.nil?
      message = "Current User: #{current_user.full_name}".colorize(:green)
    else
      message = "Current User is nil".colorize(:yellow)
    end
    logger.debug message
  end

end