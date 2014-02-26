class Admin::HomeController < Admin::AdminController
  before_filter :authenticate_admin!

  def contact
  end

  def lit_samples
  end

  def web
  end

  def home
  end
end