require 'spec_helper'

describe "petitions/edit" do
  before(:each) do
    @petition = assign(:petition, stub_model(Petition))
  end

  it "renders the edit petition form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", petition_path(@petition), "post" do
    end
  end
end
