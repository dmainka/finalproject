require 'spec_helper'

describe "songs/new" do
  before(:each) do
    assign(:song, stub_model(Song,
      :product_id => 1,
      :artist => "MyString",
      :album => "MyString",
      :time => 1,
      :snippet_url => "MyString"
    ).as_new_record)
  end

  it "renders new song form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", songs_path, "post" do
      assert_select "input#song_product_id[name=?]", "song[product_id]"
      assert_select "input#song_artist[name=?]", "song[artist]"
      assert_select "input#song_album[name=?]", "song[album]"
      assert_select "input#song_time[name=?]", "song[time]"
      assert_select "input#song_snippet_url[name=?]", "song[snippet_url]"
    end
  end
end
