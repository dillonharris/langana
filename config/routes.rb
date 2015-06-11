Rails.application.routes.draw do

  root "users#index"
  get 'signin' => 'sessions#new'
  resource :session

  get 'signup' => 'users#new'
  resources :users do
    resources :work_references
    member do
      get :confirm
    end
  end
end
