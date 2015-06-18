module Api
  module V1
    module BaseHelper
      # This module contains method declarations that will be invoked
      # whenever an error occurs in the system. these errors render out in
      # json or xml depending on the requested format.
      module Errors
        # This is used for rendering a bad request
        #
        # @param messages [Array] errors array
        # @param *args [Array] optional extra errors
        def render_bad_request(messages = [], *args)
          render @format => {messages: join_errors(messages, args) || []}, status: :bad_request
        end

        # This is used for rendering an unauthorised request
        # You can optionally pass a reason as to why the connection
        # was unauthorised.
        #
        # @param messages [Array] errors array
        # @param *args [Array] optional extra errors
        def render_forbidden(messages = [], *args)
          render @format => {messages: join_errors(messages, args) || []}, status: :forbidden
        end

        # This is used for rendering a model not found fault
        #
        # @param messages [Array] errors array
        # @param *args [Array] optional extra errors
        def render_model_not_found(messages = [], *args)
          render @format => {messages: join_errors(messages, args) || []}, status: :not_found
        end

        # This is used to render a model not saved fault
        #
        # @param messages [Array] errors array
        # @param *args [Array] optional extra errors
        def render_unprocessable_request(messages = [], *args)
          render @format => {messages: join_errors(messages, args) || []}, status: :unprocessable_entity
        end

        private

        # Combine two arrays and ensure a flat array structure
        #
        # @param a [Array] errors array
        # @param b [Array] optional extra error
        # @return [Array] the flattened array
        def join_errors(a, b)
          (a << b).flatten!
        end
      end
    end
  end
end