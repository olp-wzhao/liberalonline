class UserMailer < ActionMailer::Base
  default from: "jessenaiman@gmail.com"

  def welcome_message(user)
    @user = user
    @url = 'http://ontarioliberal.ca'
    mail(to: @user.email, subject: t(:welcome_email))
  end

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset", template_path: 'devise/mailer', template_name: 'reset_password_instructions'
  end
end
