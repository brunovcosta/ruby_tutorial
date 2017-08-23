json.extract! vote, :id, :user_id, :movie_id, :positive, :created_at, :updated_at
json.url vote_url(vote, format: :json)
