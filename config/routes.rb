Rails.application.routes.draw do

  namespace :api do
    resources :connections, only: [:index, :show, :update, :create]
  end

end
