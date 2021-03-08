json.extract! post, :id, :gamer_id, :text, :parent_post, :created_at, :updated_at
json.url post_url(post, format: :json)
