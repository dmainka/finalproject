json.array!(@vendors) do |vendor|
  json.extract! vendor, :id, :name, :rating
  json.url vendor_url(vendor, format: :json)
end
