json.array!(@customers) do |customer|
  json.extract! customer, :id, :name, :hashed_password, :salt
  json.url customer_url(customer, format: :json)
end
