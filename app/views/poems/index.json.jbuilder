json.array!(@poems) do |poem|
  json.extract! poem, :id, :poet, :title, :content
  json.url poem_url(poem, format: :json)
end
