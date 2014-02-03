json.array!(@categories) do |category|
  json.extract! category, :id, :name, :price
  json.url category_url(category, format: :json)
end
