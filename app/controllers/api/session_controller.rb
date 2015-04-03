require 'transmission'

module Api
  class SessionController < ApiController

    def index
      @session = Transmission::Model::Session.get connector: rpc_client
      render json: @session.to_json
    end

    def create
      @session = Transmission::Model::Session.get connector: rpc_client
      @session.attributes = @session.attributes.merge(session_params)
      @session.save!
      render json: @session.to_json
    end

    private

    def rpc_client
      connection = Connection.find params[:connection_id]
      connection.rpc
    end

    def session_params
      params.require(:session)
    end

  end
end