class ContactController < ApplicationController

    layout "inside_layout"

    def new
        @contact = Contact.new
    end

    def create
        @contact = Contact.new(contact_params)
        
        if @contact.valid?
            mailto_address = 'info@ontarioliberal.ca'
            if @contact.inquiry_type.eql?('technical')
				mailto_address = 'webadmin@ontarioliberal.ca'
            elsif @contact.inquiry_type.eql?('donation')
				mailto_address = 'info@ontarioliberal.ca'
            elsif @contact.inquiry_type.eql?('purchase')
				mailto_address = 'ticketsales@ontarioliberal.ca'
            elsif @contact.inquiry_type.eql?('membership')
				mailto_address = 'membership@ontarioliberal.ca'
            elsif @contact.inquiry_type.eql?('correction')
				mailto_address = 'webadmin@ontarioliberal.ca'
            else
				mailto_address = 'info@ontarioliberal.ca'
            end
            NotificationsMailer.new_message(@contact).deliver
            @contact.save
            redirect_to(root_path, :notice => "Message was successfully sent to " + mailto_address + " which from " + @contact.email)
        else
            flash.now.alert = "Please fill all fields." + params['contact[inquiry_type]'].to_s
            render :new
        end
      end

    def index
    end

    private

    def contact_params
        params.require(:contact).permit(:first_name, :last_name, :email, :phone_number, :postal_code, :body, :inquiry_type)
    end

end
