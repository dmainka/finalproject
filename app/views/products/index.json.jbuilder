json.array!(@products) do |product|
  json.extract! product, :id, :vendor_id, :name, :description, :price, :image_url, :department_id
  json.url product_url(product, format: :json)
end
