Rails.application.routes.draw do

  devise_for :users

  resources :projects do
  end

  resources :members, only: [:update, :show] do
    member do
      get :settings, to: "members#settings"
    end
  end

  resources :teams do
    member do
      post :invite_member, to: "teams#invite_member"
    end
  end

  resources :address, only: [] do 
    collection do 
      get "/:province_id/cities", to: "address#cities"
      get "/provinces", to: "address#provinces"
    end
  end

  root :to => "home#index"
end
