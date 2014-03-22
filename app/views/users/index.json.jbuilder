json.array!(@users) do |user|
  json.extract! user, :id, :email, :zipcode
  json.url user_url(user, format: :json)
end
