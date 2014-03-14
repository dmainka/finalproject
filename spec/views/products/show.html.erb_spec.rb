require 'spec_helper'

describe "products/show" do
  before(:each) do
    @product = assign(:product, stub_model(Product,
      :vendor_id => 1,
      :name => "Name",
      :description => "MyText",
      :price => "9.99",
      :image_url => "Image Url",
      :department_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/9.99/)
    rendered.should match(/Image Url/)
    rendered.should match(/2/)
  end
end
