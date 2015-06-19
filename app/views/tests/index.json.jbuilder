json.array!(@tests) do |test|
  json.extract! test, :id, :name, :description, :begins_at, :ends_at
  json.url test_url(test, format: :json)
end
