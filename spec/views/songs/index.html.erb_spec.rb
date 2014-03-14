require 'spec_helper'

describe "songs/index" do
  before(:each) do
    assign(:songs, [
      stub_model(Song,
        :product_id => 1,
        :artist => "Artist",
        :album => "Album",
        :time => 2,
        :snippet_url => "Snippet Url"
      ),
      stub_model(Song,
        :product_id => 1,
        :artist => "Artist",
        :album => "Album",
        :time => 2,
        :snippet_url => "Snippet Url"
      )
    ])
  end

  it "renders a list of songs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Artist".to_s, :count => 2
    assert_select "tr>td", :text => "Album".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Snippet Url".to_s, :count => 2
  end
end
