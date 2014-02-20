class AdminController < ActionController::Base
  before_filter :authenticate_admin!

  def contact
  end

  def lit_samples
  end

  def web
  end
end