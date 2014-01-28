require 'spec_helper'

describe "lawnsign_requests/new" do
  before(:each) do
    assign(:lawnsign_request, stub_model(LawnsignRequest).as_new_record)
  end

  it "renders new lawnsign_request form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", lawnsign_requests_path, "post" do
    end
  end
end
