Rails.application.routes.draw do

  resources :workers do 
    member do
      get :confirm
      post :verify_confirmation
    end
  end

  root "workers#index"
  get 'signin' => 'sessions#new'
  get 'workers_signin' => 'workers_sessions#new'
  resource :workers_session
  resource :session
  get 'forgot_password' => 'users#forgot_password'
  post 'forgot_password' => 'users#send_reset_code'

  get 'signup_worker' => 'workers#new'
  get 'signup_employer' => 'users#new_employer'
  get 'choose_role' => 'visitors#choose_role'
  resources :users do
    resources :work_references
    member do
      get :edit_worker
      get :edit_employer
      get :new_password
      patch :reset_password
      get :confirm
      post :verify_confirmation
      get :resend_confirmation
    end
  end

  get "users/filter/:scope" => "users#index", as: :filtered_users
end
