require 'spec_helper'

describe "orders/edit" do
  before(:each) do
    @order = assign(:order, stub_model(Order,
      :customer_id => 1,
      :total => "9.99",
      :ship_to_name => "MyString",
      :ship_to_address => "MyText",
      :payment_type => "MyString"
    ))
  end

  it "renders the edit order form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", order_path(@order), "post" do
      assert_select "input#order_customer_id[name=?]", "order[customer_id]"
      assert_select "input#order_total[name=?]", "order[total]"
      assert_select "input#order_ship_to_name[name=?]", "order[ship_to_name]"
      assert_select "textarea#order_ship_to_address[name=?]", "order[ship_to_address]"
      assert_select "input#order_payment_type[name=?]", "order[payment_type]"
    end
  end
end
