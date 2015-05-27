module Api
  module V1
    module BaseHelper
      # This module exists in order to catch exceptions in the system that
      # may not have been raised in the controller. These are to prevent the
      # front end application from getting no feedback and ensure that
      # important exceptions are always caught
      module ErrorCatcher
        # Raise a bad request if it has not been raised previously.
        ActionController::Base.rescue_from ActiveRecord::RecordInvalid do |record|
          render_bad_request record
        end

        # Raise a record not found fault if it has not been raised previously.
        ActionController::Base.rescue_from ActiveRecord::RecordNotFound do |record|
          render_model_not_found record
        end

        # Raise a record not saved fault.
        ActionController::Base.rescue_from ActiveRecord::RecordNotSaved do |record|
          render_unprocessable_request record
        end
      end
    end
  end
end