class ConstitutionController < ApplicationController

  layout 'inside_layout'

  def index
  end

  def show
    #@constitution_page_content = '<h1>Constitution of the Ontario Liberal Party</h1><p>Page ' + params[:id] + '</p>'
    @constitution_page_content = File.read(Rails.root.join('public', 'constitutions', params[:id] + '.txt'))
  end

end
