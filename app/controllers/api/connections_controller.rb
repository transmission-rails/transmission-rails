module Api
  class ConnectionsController < ApiController

    def index
      @connections = Connection.all
    end

    def show
      @connection = Connection.find params[:id]
    end

  end
end