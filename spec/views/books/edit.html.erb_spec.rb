require 'spec_helper'

describe "books/edit" do
  before(:each) do
    @book = assign(:book, stub_model(Book,
      :product_id => 1,
      :author => "MyString",
      :pages => 1
    ))
  end

  it "renders the edit book form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", book_path(@book), "post" do
      assert_select "input#book_product_id[name=?]", "book[product_id]"
      assert_select "input#book_author[name=?]", "book[author]"
      assert_select "input#book_pages[name=?]", "book[pages]"
    end
  end
end
