require 'spec_helper'

describe "orders/index" do
  before(:each) do
    assign(:orders, [
      stub_model(Order,
        :customer_id => 1,
        :total => "9.99",
        :ship_to_name => "Ship To Name",
        :ship_to_address => "MyText",
        :payment_type => "Payment Type"
      ),
      stub_model(Order,
        :customer_id => 1,
        :total => "9.99",
        :ship_to_name => "Ship To Name",
        :ship_to_address => "MyText",
        :payment_type => "Payment Type"
      )
    ])
  end

  it "renders a list of orders" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Ship To Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Payment Type".to_s, :count => 2
  end
end
