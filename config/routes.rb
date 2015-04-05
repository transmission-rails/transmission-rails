Rails.application.routes.draw do

  root 'home#index'
  post 'login', to: 'home#login'
  post 'logout', to: 'home#logout'

  namespace :api do
    resources :connections, only: [:index, :show, :update, :create, :destroy] do
      resources :session_stats, only: [:index]
      resources :session, only: [:index, :create]
      resources :torrents, only: [:index, :show, :update, :create, :destroy]
      post 'torrents/start_all', to: 'torrents#start_all'
      post 'torrents/stop_all', to: 'torrents#stop_all'
      post 'torrents/:id/:torrent_action', to: 'torrents#torrent_action'
    end
  end

end
