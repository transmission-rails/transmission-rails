Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  mount_devise_token_auth_for 'User', at: 'auth'

  get '/' => 'layouts#index', as: 'root'

  #
  # Api Resources
  #
  namespace :api do
    namespace :v1 do
      get '/me', to: 'me#index'
      put '/me', to: 'me#update'
      put '/me/password', to: 'me#password'
      put '/me/avatar', to: 'me#avatar'

      resources :users
    end
  end

  match '/*a', to: 'layouts#index', via: [:get, :post, :put, :delete]
end
