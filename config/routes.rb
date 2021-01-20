Rails.application.routes.draw do
  resources :galleries
  devise_for :users
  get 'otp_confirmed_check', to: 'galleries#otp_confirmed_check', as: 'otp_confirmed_check'
  post 'otp_validate', to: 'galleries#otp_validate', as: 'otp_validate'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'galleries#index'
end
