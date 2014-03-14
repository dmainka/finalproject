require 'spec_helper'

describe "songs/edit" do
  before(:each) do
    @song = assign(:song, stub_model(Song,
      :product_id => 1,
      :artist => "MyString",
      :album => "MyString",
      :time => 1,
      :snippet_url => "MyString"
    ))
  end

  it "renders the edit song form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", song_path(@song), "post" do
      assert_select "input#song_product_id[name=?]", "song[product_id]"
      assert_select "input#song_artist[name=?]", "song[artist]"
      assert_select "input#song_album[name=?]", "song[album]"
      assert_select "input#song_time[name=?]", "song[time]"
      assert_select "input#song_snippet_url[name=?]", "song[snippet_url]"
    end
  end
end
