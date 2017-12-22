json.array!(@users) do |user|
  json.id             user.id
  json.identification user.identification
  json.name           user.name
  json.last_name      user.last_name
  json.image_url      user.profile_picture.url
end