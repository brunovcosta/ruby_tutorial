require 'test_helper'

class MoviesControllerTest < ActionController::TestCase
  setup do
    @movie = movies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movie" do
    assert_difference('Movie.count') do
      post :create, movie: { Actors: @movie.Actors, Description: @movie.Description, Director: @movie.Director, Genre: @movie.Genre, Metascore: @movie.Metascore, Rank: @movie.Rank, Rating: @movie.Rating, Revenue: @movie.Revenue, Runtime: @movie.Runtime, Title: @movie.Title, Votes: @movie.Votes, Year: @movie.Year }
    end

    assert_redirected_to movie_path(assigns(:movie))
  end

  test "should show movie" do
    get :show, id: @movie
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @movie
    assert_response :success
  end

  test "should update movie" do
    patch :update, id: @movie, movie: { Actors: @movie.Actors, Description: @movie.Description, Director: @movie.Director, Genre: @movie.Genre, Metascore: @movie.Metascore, Rank: @movie.Rank, Rating: @movie.Rating, Revenue: @movie.Revenue, Runtime: @movie.Runtime, Title: @movie.Title, Votes: @movie.Votes, Year: @movie.Year }
    assert_redirected_to movie_path(assigns(:movie))
  end

  test "should destroy movie" do
    assert_difference('Movie.count', -1) do
      delete :destroy, id: @movie
    end

    assert_redirected_to movies_path
  end
end
