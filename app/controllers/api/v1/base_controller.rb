module Api
  module V1
    # Common ancestor of all V1 controllers
    # any functionality provided here is available to all child classes
    class BaseController < ApplicationController
      include BaseHelper

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