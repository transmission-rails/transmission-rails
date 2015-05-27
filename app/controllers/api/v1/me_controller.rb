module Api
  module V1
    # Any actions related with the me (current_user) resource
    #
    class MeController < BaseController
      before_action :authenticate_user!

      CURRENT_PASSWORD_INVALID = 'Current password is invalid!'
      INVALID_PASSWORD_CONFIRMATION = 'New password does not match confirmation!'

      def index
        @current_user = current_user
        respond_with @current_user
      end

      def update
        @current_user = current_user
        @current_user.update! user_params
        respond_with @current_user
      end

      def avatar
        @current_user = current_user
        @current_user.avatar = params[:file]
        @current_user.save!
        respond_with @current_user
      end

      private

      def user_params
        params.required(:user).permit :name,
                                      :username,
                                      :email,
                                      :password,
                                      :password_confirmation
      end
    end
  end
end
