json.array!(@verbes) do |verbe|
  json.extract! verbe, :id, :infinitif
  json.url verbe_url(verbe, format: :json)
end
