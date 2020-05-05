json.array!(@children) do |child|
  json.extract! child, :id, :first_name, :last_name, :active
  json.url child_url(child, format: :json)
end
