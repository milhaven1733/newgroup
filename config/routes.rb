Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  namespace :mine do
    resources :tickets
  end
end
