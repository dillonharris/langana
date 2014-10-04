Rails.application.routes.draw do
  resources :users

get "movies" => "movies#index"
end
