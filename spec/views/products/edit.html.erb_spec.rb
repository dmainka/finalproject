require 'spec_helper'

describe "products/edit" do
  before(:each) do
    @product = assign(:product, stub_model(Product,
      :vendor_id => 1,
      :name => "MyString",
      :description => "MyText",
      :price => "9.99",
      :image_url => "MyString",
      :department_id => 1
    ))
  end

  it "renders the edit product form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", product_path(@product), "post" do
      assert_select "input#product_vendor_id[name=?]", "product[vendor_id]"
      assert_select "input#product_name[name=?]", "product[name]"
      assert_select "textarea#product_description[name=?]", "product[description]"
      assert_select "input#product_price[name=?]", "product[price]"
      assert_select "input#product_image_url[name=?]", "product[image_url]"
      assert_select "input#product_department_id[name=?]", "product[department_id]"
    end
  end
end
