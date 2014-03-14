require 'spec_helper'

describe "vendors/new" do
  before(:each) do
    assign(:vendor, stub_model(Vendor,
      :name => "MyString",
      :rating => 1
    ).as_new_record)
  end

  it "renders new vendor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", vendors_path, "post" do
      assert_select "input#vendor_name[name=?]", "vendor[name]"
      assert_select "input#vendor_rating[name=?]", "vendor[rating]"
    end
  end
end
