module Api
  class ConnectionsController < ApiController

    def index
      @connections = Connection.all
    end

  end
end