Rails.application.routes.draw do

  root "users#index"
  get 'signin' => 'sessions#new'
  resource :session
  get 'forgot_password' => 'users#forgot_password'
  post 'forgot_password' => 'users#send_reset_code'

  get 'signup' => 'users#new'
  resources :users do
    resources :work_references
    member do
      get :new_password
      get :confirm
      post :verify_confirmation
      get :resend_confirmation
    end
  end
end
