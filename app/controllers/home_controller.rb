class HomeController < ApplicationController

  def index

  end

  def login
    authenticate_with_http_basic do |username, password|
      user = User.authenticate! username, password
      if user
        session[:user_id] = user.id
        render json: {message: 'ok'}
        return
      end
    end
    render json: {message: 'nope'}, status: 401
  end

  def logout
    session.delete :user_id
    render json: {message: 'ok'}
  end

end