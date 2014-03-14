json.array!(@songs) do |song|
  json.extract! song, :id, :product_id, :artist, :album, :time, :snippet_url
  json.url song_url(song, format: :json)
end
