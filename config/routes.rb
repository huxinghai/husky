Rails.application.routes.draw do

  devise_for :users

  resources :projects do
    collection do 
      post :upload, to: "projects#upload"
    end
  end

  resources :members, only: [:update, :show] do
    member do
      get :settings, to: "members#settings"
      put :change_password, to: "members#change_password"
      post :change_avatar, to: "members#change_avatar"
    end
  end

  resources :teams do
    member do
      post :invite_member, to: "teams#invite_member"
    end
  end

  resources :attachments, only: [:destroy] do 
  end

  resources :categories do 
    member do 
      get :childrens
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
