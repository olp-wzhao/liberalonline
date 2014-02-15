require 'spec_helper'

describe "petitions/new" do
  before(:each) do
    assign(:petition, stub_model(Petition).as_new_record)
  end

  it "renders new petition form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", petitions_path, "post" do
    end
  end
end
