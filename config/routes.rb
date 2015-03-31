Rails.application.routes.draw do

  namespace :api do
    resources :connections, only: [:index, :show, :update, :create, :destroy]
  end

end
