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
    end
  end
end