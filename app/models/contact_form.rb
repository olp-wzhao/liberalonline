class ContactForm < MailForm::Base
  attributes :name,  :validate => true
  attributes :email, :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attributes :type,  :validate => ["General", "Interface bug"]
  attributes :message
  attributes :screenshot, :attachment => true, :validate => :interface_bug?
  attributes :nickname,   :captcha => true

  def interface_bug?
    if type == 'Interface bug' && screenshot.nil?
      self.errors.add(:screenshot, "can't be blank on interface bugs")
    end
  end

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
        :subject => "My Contact Form",
        :to => "your.email@your.domain.com",
        :from => %("#{name}" <#{email}>)
    }
  end
end