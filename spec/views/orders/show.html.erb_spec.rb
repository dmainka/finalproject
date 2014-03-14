require 'spec_helper'

describe "orders/show" do
  before(:each) do
    @order = assign(:order, stub_model(Order,
      :customer_id => 1,
      :total => "9.99",
      :ship_to_name => "Ship To Name",
      :ship_to_address => "MyText",
      :payment_type => "Payment Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/9.99/)
    rendered.should match(/Ship To Name/)
    rendered.should match(/MyText/)
    rendered.should match(/Payment Type/)
  end
end
