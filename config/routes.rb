Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  namespace :mine do
    resources :tickets do
      resources :group_prices
    end

    get :profile
    patch :profile, to: :update_profile
  end

end
