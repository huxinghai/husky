Rails.application.routes.draw do

  devise_for :users

  resources :projects do
  end

  resources :members do
    member do
      get :settings, to: "members#settings"
    end
  end

  resources :teams do
  end

  root :to => "home#index"
end
