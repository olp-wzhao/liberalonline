class ToolkitController < ApplicationController
  before_filter :authenticate_user!

  #Admin routes
  def index
    @documents = Document.toolkit.limit(10)
    render :layout => "toolkit_layout"
  end

  def show
    @document = Document.find_by(id: params[:id])
    render :layout => "toolkit_layout"
  end
end