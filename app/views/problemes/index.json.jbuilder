json.array!(@problemes) do |probleme|
  json.extract! probleme, :id, :texte, :corrige, :date_correction
  json.url probleme_url(probleme, format: :json)
end
