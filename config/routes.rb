Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  get 'search', to: "home#search", as: "search"
  get 'merchant', to: "profile#merchant", as: "merchant"

  resources :tickets do
    resources :groups do
      member do
        post :join_pay
      end
    end
  end

  namespace :mine do
    resources :tickets do
      resources :group_prices
    end
    resource :wallet

    get :profile, :edit_profile
    patch :profile, action: :update_profile
  end

end
