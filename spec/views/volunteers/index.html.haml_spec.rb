require 'spec_helper'

describe "volunteers/index" do
  before(:each) do
    assign(:volunteers, [
      stub_model(Volunteer),
      stub_model(Volunteer)
    ])
  end

  it "renders a list of volunteers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
