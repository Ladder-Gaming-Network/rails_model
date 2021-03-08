json.extract! user, :id, :username, :lastname, :stream_link, :description, :timezone_code, :created_at, :updated_at
json.url user_url(user, format: :json)
