require 'spec_helper'

describe "songs/show" do
  before(:each) do
    @song = assign(:song, stub_model(Song,
      :product_id => 1,
      :artist => "Artist",
      :album => "Album",
      :time => 2,
      :snippet_url => "Snippet Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Artist/)
    rendered.should match(/Album/)
    rendered.should match(/2/)
    rendered.should match(/Snippet Url/)
  end
end
