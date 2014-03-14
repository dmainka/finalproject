json.array!(@orders) do |order|
  json.extract! order, :id, :customer_id, :order_date, :total, :ship_to_name, :ship_to_address, :payment_type
  json.url order_url(order, format: :json)
end
