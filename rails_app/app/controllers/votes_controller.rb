class VotesController < ApplicationController
  def create
    @vote = Vote.create(user_id: session[:user][:id], movie_id: params[:movie_id])

    redirect_to :back
  end

  def destroy
    Vote.find_by(user_id: session[:user][:id], movie_id: params[:movie_id]).destroy

    redirect_to :back
  end
end
