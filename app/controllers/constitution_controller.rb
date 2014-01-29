class ConstitutionController < ApplicationController

    

    def index
        load_application_action
        load_application_layout
    end

    def show
        load_application_action
        load_application_layout
        
        #@constitution_page_content = '<h1>Constitution of the Ontario Liberal Party</h1><p>Page ' + params[:id] + '</p>'
        @constitution_page_content = File.read(Rails.root.join('public', 'constitutions', params[:id] + '.txt'))
    end

end
