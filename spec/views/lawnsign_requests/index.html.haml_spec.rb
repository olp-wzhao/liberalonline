require 'spec_helper'

describe "lawnsign_requests/index" do
  before(:each) do
    assign(:lawnsign_requests, [
      stub_model(LawnsignRequest),
      stub_model(LawnsignRequest)
    ])
  end

  it "renders a list of lawnsign_requests" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
