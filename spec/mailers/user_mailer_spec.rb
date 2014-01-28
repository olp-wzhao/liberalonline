require "spec_helper"

describe UserMailer do
  describe "welcome message" do
    let(:user) { FactoryGirl.create(:user, :invitation_token => "anything") }
    let(:mail) { UserMailer.welcome_message(user) }

    it "send user password reset url" do
      #mail.subject.should eq("Password Reset")
      mail.to.should eq([user.email])
      mail.from.should eq(["jessenaiman@gmail.com"])
      #mail.body.encoded.should match(edit_password_reset_path(user.password_reset_token))
    end
  end

  describe "guest user facebook login" do
    it "redirects to registration url" do
    end

    it "fills in available fields on registration form" do
    end
  end

  
end

#things to test
