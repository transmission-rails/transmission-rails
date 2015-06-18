class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  alias_method :devise_current_user, :current_user

  def current_user
    @current_user = devise_current_user
    @current_user.last_seen = Time.now
    @current_user.save!
    @current_user
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :username
  end
end
