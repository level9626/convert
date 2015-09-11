json.array!(@converters) do |converter|
  json.extract! converter, :id, :name
  json.url converter_url(converter, format: :json)
end
