Rails.application.routes.draw do
  resources :votes
  resources :movies
  resources :users
  
  root "extra#home"

  post "/login" => "users#login"
end
