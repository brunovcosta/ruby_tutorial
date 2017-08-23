class ExtraController < ApplicationController
  def home
	if session[:user]
		ids = User.find(session[:user]["id"]).movies.pluck(:id)
		@movies = Movie.tfidf(id: ids)

	end
  end
end
