class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, if: lambda { Rails.env == 'production'}
end
