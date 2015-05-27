module Api
  module V1
    # Any actions related with the users resource
    #
    class UsersController < BaseController
      before_action :set_instances, only: [:show, :update, :destroy]

      def index
        @users = User.all
        respond_with @users
      end

      def show
        respond_with @user
      end

      def create
        @user = User.create! user_params
        respond_with @user
      end

      def update
        @user.update! user_params
        respond_with @user
      end

      def destroy
        @user.destroy!
        respond_with @user
      end

      private

      def set_instances
        @user = User.find params[:id]
      end

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