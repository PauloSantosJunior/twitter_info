Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/auth/:provider/callback', to: 'sessions#create'

  resources :users do
    collection do
      get :login
      post :login
      put :login

      get "create"
      post "create"
      put "create"
    end
  end

  resources :twitter_info do
    collection do
      get :twitter_search
      post :twitter_search
      put :twitter_search

      get  :twitter_geo_location
      post :twitter_geo_location
      put  :twitter_geo_location
    end
  end

  resources :tweets
  resources :twitter_info
  resources :sessions

  root to: "users#index"

end
