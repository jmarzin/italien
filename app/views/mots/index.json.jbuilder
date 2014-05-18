json.array!(@mots) do |mot|
  json.extract! mot, :id, :mot_directeur, :francais, :italien
  json.url mot_url(mot, format: :json)
end
