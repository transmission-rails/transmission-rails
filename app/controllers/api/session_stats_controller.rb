require 'transmission'

module Api
  class SessionStatsController < ApiController

    def index
      @session_stats = Transmission::Model::SessionStats.get connector: rpc_client
      render json: @session_stats.to_json
    end

    private

    def rpc_client
      connection = Connection.find params[:connection_id]
      connection.rpc
    end

  end
end