module Api
  class ConnectionsController < ApiController

    def index
      @connections = Connection.all
    end

    def show
      @connection = Connection.find params[:id]
    end

    def update
      @connection = Connection.find params[:id]
      @connection.update_attributes! connection_params
    end

    private

    def connection_params
      params.require(:connection).permit(:name, :host, :port, :path, :ssl, :username, :password, :credentials)
    end

  end
end