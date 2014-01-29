require 'spec_helper'
require 'helpers/invitable_helpers'

RSpec.configure do |c|
  c.include InvitableHelpers
end

describe User do
 	
  #its(:riding_id) { should_not be_nil }
 	
  it "date of birth is required for completed registration" do
    subject.should_not be_valid
  end

  context 'with an facebook profile attached' do
    subject { User.new(name: 'rspec_user', identities: [facebook]) }
    let(:facebook) { Identity.new(provider: 'facebook') }

    its(:identities) { should include(facebook) }
  end

  context "after create" do
    let(:user) { FactoryGirl.create(:user) }
    it 'calls "add_to_riding" on user creation' do
      user.should_recieve(:add_to_riding)
      user.save
    end
  end

  context "#invitations" do
    
    before(:each) do
      setup_mailer
    end

    let(:user) { new_user }
    let(:admin) { User.create(email: 'spec@olp.ca') }
    let(:guest) { new_user }
    let(:mail) { stub(:mail, deliver: true) }

    its(:invitation_token) { should be_nil }

    it "sends an email" do
      guest.invite!
      ActionMailer::Base.deliveries.count.should == 1
    end

  end
end