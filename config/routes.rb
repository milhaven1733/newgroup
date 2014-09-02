Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  get 'search', to: "home#search", as: "search"
  get 'merchant', to: "profile#merchant", as: "merchant"

  namespace :mine do
    resources :tickets do
      resources :group_prices
    end

    get :profile, :edit_profile
    patch :profile, to: :update_profile
  end

end
