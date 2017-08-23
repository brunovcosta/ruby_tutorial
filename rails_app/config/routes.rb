Rails.application.routes.draw do
  resources :votes
  resources :users
  resources :movies
  root "extra#home"
  post "/login" => "users#login"
  get "/votar" => "votes#create"
  get "/desvotar" => "votes#destroy"
end
