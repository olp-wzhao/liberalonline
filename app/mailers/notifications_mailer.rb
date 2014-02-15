class NotificationsMailer < ActionMailer::Base
  default :from => "jessenaiman@gmail.com"
  default :to => "jessenaiman@gmail.com"

  def new_message(message)
    @contact = message
    mail(:subject => message.body)
  end
end
