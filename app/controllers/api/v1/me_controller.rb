module Api
  module V1
    # Any actions related with the me (current_user) resource
    #
    class MeController < BaseController
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

      def password
        @current_user = current_user
        return false unless update_password params[:user][:current_password],
                                            params[:user][:password],
                                            params[:user][:password_confirmation]
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
                                      :skype,
                                      :twitter,
                                      :facebook,
                                      :linkedin,
                                      :username,
                                      :email,
                                      :password,
                                      :password_confirmation
      end

      def update_password(current_password, password, confirmation)
        errors = []
        errors.push(CURRENT_PASSWORD_INVALID) unless @current_user.valid_password?(current_password)
        errors.push(INVALID_PASSWORD_CONFIRMATION) unless password == confirmation
        render_bad_request errors and return false unless errors.empty?
        @current_user.password = password
        @current_user.save!
        true
      end
    end
  end
end
