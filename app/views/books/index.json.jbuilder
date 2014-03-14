json.array!(@books) do |book|
  json.extract! book, :id, :product_id, :author, :pages
  json.url book_url(book, format: :json)
end
