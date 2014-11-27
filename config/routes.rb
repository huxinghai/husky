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
    member do
      post :invite_member, to: "teams#invite_member"
    end
  end

  root :to => "home#index"
end
