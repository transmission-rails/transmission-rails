class ApiController < ApplicationController
  class UnauthorizedError < StandardError; end
  attr_accessor :current_user

  before_filter :authenticate
  before_filter :check_auth

  def authenticate
    authenticate_with_http_basic do |username, password|
      @current_user = User.authenticate! username, password
    end
    if session[:user_id]
      @current_user = User.find session[:user_id]
    end
  end

  def check_auth
    raise UnauthorizedError unless current_user
  end

end
