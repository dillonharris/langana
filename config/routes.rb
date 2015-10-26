Rails.application.routes.draw do

  root "users#index"
  get 'signin' => 'sessions#new'
  resource :session
  get 'forgot_password' => 'users#forgot_password'
  post 'forgot_password' => 'users#send_reset_code'

  get 'signup_worker' => 'users#new_worker'
  get 'signup_employer' => 'users#new_employer'
  get 'choose_role' => 'visitors#choose_role'
  resources :users do
    resources :work_references
    member do
      get :new_password
      patch :reset_password
      get :confirm
      post :verify_confirmation
      get :resend_confirmation
    end
  end

  get "users/filter/:scope" => "users#index", as: :filtered_users
end
