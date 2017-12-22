json.extract! user, :id, :identification, :name, :last_name, :profile_picture.url,  :email
json.url user_url(user, format: :json)