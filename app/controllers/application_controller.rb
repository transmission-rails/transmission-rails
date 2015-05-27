class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActionController::InvalidAuthenticityToken do
    render json: { :error => 'missing_csrf' }, status: :bad_request
  end

  def handle_unverified_request
    super
    raise ActionController::InvalidAuthenticityToken
  end

  def handle_missing_session
    render json: { :error => 'no_session' }, status: :unauthorized
  end
end
