Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  get '/' => 'layouts#index', as: 'root'

  post '/session/login' => 'session#login'
  get '/session/logout' => 'session#logout'

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
