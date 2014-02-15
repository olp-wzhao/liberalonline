class ContactController < ApplicationController

    layout "inside_layout"

    def new
    	@contact = Contact.new
    end

    def create
	    @contact = Contact.new(contact_params)
	    
	    if @contact.valid?
	      NotificationsMailer.new_message(@contact).deliver
	      @contact.save
	      redirect_to(root_path, :notice => "Message was successfully sent.")
	    else
	      flash.now.alert = "Please fill all fields."
	      render :new
	    end
	  end

    def index
    end

    private

    	def contact_params
    		params.require(:contact).permit(:first_name, :last_name, :email, :phone_number, :postal_code, :body)
    	end
end
