require 'spec_helper'

describe "lawnsign_requests/show" do
  before(:each) do
    @lawnsign_request = assign(:lawnsign_request, stub_model(LawnsignRequest))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
