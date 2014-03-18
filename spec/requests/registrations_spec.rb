require 'spec_helper'

describe 'Registration' do
  let(:user) { FactoryGirl.create(:user) }
  subject { user }

  it 'posts a new user' do

    post new_user_registration_url, user.attributes
    response.status.should be(200)
  end
end