module Api
  module V1
    # this module includes all the helpers for V1 api
    # this makes them available in the controller layer with a simple include statement
    module BaseHelper
      include Errors
      include ErrorCatcher
    end
  end
end