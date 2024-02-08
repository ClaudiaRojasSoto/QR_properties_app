Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :properties do
    resource :qr_code, only: [:show], controller: 'qr_codes'
  end
end
