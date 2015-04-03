Rails.application.routes.draw do

  namespace :api do
    resources :connections, only: [:index, :show, :update, :create, :destroy] do
      resources :torrents, only: [:index, :show, :update, :create, :destroy]
      post 'torrents/start_all', to: 'torrents#start_all'
      post 'torrents/stop_all', to: 'torrents#stop_all'
      post 'torrents/:id/:torrent_action', to: 'torrents#torrent_action'
    end
  end

end
