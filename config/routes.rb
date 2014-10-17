Rails.application.routes.draw do
  root "users#index"
  get 'signin' => 'sessions#new'
  resource :session

  get 'signup' => 'users#new'
  resources :users
end
