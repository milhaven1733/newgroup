Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  get 'merchant/:id',  to: "profile#merchant", as: "merchant"
  get 'user/:id',      to: "profile#user",     as: "user"
  post 'merchant/:id/like', to: 'profile#like', as: 'like_merchant'
  get '/search',   to: "home#search",      as: :search
  get '/set_city', to: "home#set_city",    as: :set_city
  get 'about_us',  to: "home#about_us",    as: :about_us

  resources :tickets do
    resources :groups do
      member do
        post :join_pay
      end
    end
    resources :orders
    member do
      post :like
      post :calc_price
    end
  end

  namespace :mine do
    resources :tickets do
      resources :group_prices
    end
    resource :wallet do
      post :recharge, :withdraw
    end

    get :profile, :edit_profile
    patch :profile, action: :update_profile

    resources :orders
  end
end
