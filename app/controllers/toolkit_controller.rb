class ToolkitController < ApplicationController
  before_filter :authenticate_user!

  #Admin routes
  def index
    search
    @documents = @documents.limit(5)
    render :layout => 'toolkit_layout'
  end

  def show
    @document = Document.find_by(id: params[:id])
    render :layout => 'toolkit_layout'
  end

  def search
    @documents = Document.toolkit
    params.each do |key, value|
      # target groups using regular expressions
      skip_list = %w(auth_token action controller format scope)
      unless skip_list.include?(key)
        @documents = @documents.where(key => value)
      end
    end
  end
end