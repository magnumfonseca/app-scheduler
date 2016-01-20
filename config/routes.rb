Rails.application.routes.draw do
  devise_for :users
  root to: 'scheduler#index'
  resources :events, only: [:create, :destroy]
end
