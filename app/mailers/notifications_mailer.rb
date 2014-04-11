class NotificationsMailer < ActionMailer::Base
  default :from => "jessenaiman@gmail.com"
  default :to => "jessenaiman@gmail.com"

  def new_message(message, mailto_address='info@ontarioliberal.ca')
    @contact = message
    mailto_address = 'wzhao@liberal.ola.org' # For test 
    mail(:from => @contact.email, :to => mailto_address, :subject => message.body)
  end
end
