Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root "home#index"

  devise_for :users, controllers: { registrations: "registrations", sessions: "sessions" }

  get 'merchant/:id',  to: "profile#merchant", as: "merchant"
  get 'user/:id',      to: "profile#user",     as: "user"
  post 'merchant/:id/like', to: 'profile#like', as: 'like_merchant'
  get '/search',   to: "home#search",      as: :search
  get '/mobile_search', to: "home#mobile_search", as: :mobile_search
  get '/set_city', to: "home#set_city",    as: :set_city

  controller :static_page do
    get 'about', as: :about
  end

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
