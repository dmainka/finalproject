require 'spec_helper'

describe "books/index" do
  before(:each) do
    assign(:books, [
      stub_model(Book,
        :product_id => 1,
        :author => "Author",
        :pages => 2
      ),
      stub_model(Book,
        :product_id => 1,
        :author => "Author",
        :pages => 2
      )
    ])
  end

  it "renders a list of books" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Author".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
