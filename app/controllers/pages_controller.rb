class PagesController < ApplicationController
  include HighVoltage::StaticPage

  before_action :set_user

  layout :layout_for_page

  private

  def layout_for_page
    'microsite'
  end

  def set_user
    current_user ||= User.new
    @user = current_user
  end
end
