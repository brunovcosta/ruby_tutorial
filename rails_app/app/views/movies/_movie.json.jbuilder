json.extract! movie, :id, :Rank, :Title, :Genre, :Description, :Director, :Actors, :Year, :Runtime, :Rating, :Votes, :Revenue, :Metascore, :created_at, :updated_at
json.url movie_url(movie, format: :json)
