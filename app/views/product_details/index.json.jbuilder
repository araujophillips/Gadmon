json.array!(@product_details) do |product_detail|
  json.extract! product_detail, :id, :product_id, :serial, :comment
  json.url product_detail_url(product_detail, format: :json)
end
