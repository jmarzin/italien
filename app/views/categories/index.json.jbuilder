json.array!(@categories) do |category|
  json.extract! category, :id, :numero, :description
  json.url category_url(category, format: :json)
end
