require 'spec_helper'

describe "cart_items/new" do
  before(:each) do
    assign(:cart_item, stub_model(CartItem,
      :customer_id => 1,
      :product_id => 1,
      :quantity => 1
    ).as_new_record)
  end

  it "renders new cart_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", cart_items_path, "post" do
      assert_select "input#cart_item_customer_id[name=?]", "cart_item[customer_id]"
      assert_select "input#cart_item_product_id[name=?]", "cart_item[product_id]"
      assert_select "input#cart_item_quantity[name=?]", "cart_item[quantity]"
    end
  end
end
