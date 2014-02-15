require 'spec_helper'

describe "petitions/index" do
  before(:each) do
    assign(:petitions, [
      stub_model(Petition),
      stub_model(Petition)
    ])
  end

  it "renders a list of petitions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
