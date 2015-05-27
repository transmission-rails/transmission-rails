module Api
  module V1
    # Common ancestor of all V1 controllers
    # any functionality provided here is available to all child classes
    class BaseController < ApplicationController
      include BaseHelper

      protect_from_forgery with: :null_session, if: proc { |c| c.request.format == 'application/json' }

      before_filter :determine_format

      FORMATS = [:json, :xml]
      FORMATS.each { |format| respond_to format }

      def determine_format
        @format = :json
        @format = :xml if request.headers['Accept'] == /application\/xml/
      end

      def current_user
        return false unless doorkeeper_token
        @current_user = User.find doorkeeper_token.resource_owner_id
        @current_user.last_seen = Time.now
        @current_user.save!
        @current_user
      end
    end
  end
end