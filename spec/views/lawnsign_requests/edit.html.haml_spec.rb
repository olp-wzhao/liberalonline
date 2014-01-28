require 'spec_helper'

describe "lawnsign_requests/edit" do
  before(:each) do
    @lawnsign_request = assign(:lawnsign_request, stub_model(LawnsignRequest))
  end

  it "renders the edit lawnsign_request form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", lawnsign_request_path(@lawnsign_request), "post" do
    end
  end
end
