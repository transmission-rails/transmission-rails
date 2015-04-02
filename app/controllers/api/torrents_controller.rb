require 'transmission'

module Api
  class TorrentsController < ApiController

    def index
      @torrents = Transmission::Model::Torrent.all connector: rpc_client
      render json: @torrents.to_json
    end

    def show
      ids = params[:id].split(',').collect { |id| id.to_i }
      @torrent = Transmission::Model::Torrent.find ids, connector: rpc_client
      render json: @torrent.to_json
    end

    def update
      @torrent = Transmission::Model::Torrent.find params[:id].to_i, connector: rpc_client
      @torrent.attributes = @torrent.attributes.merge(torrent_params)
      @torrent.save!
      render json: @torrent.to_json
    end

    def create
      arguments = {'filename' => torrent_create_params}
      @torrent = Transmission::Model::Torrent.add arguments: arguments, connector: rpc_client
      render json: @torrent.to_json
    end

    def destroy
      @torrent = Transmission::Model::Torrent.find params[:id].to_i, connector: rpc_client
      @torrent.delete!
      render json: @torrent.to_json
    end

    private

    def rpc_client
      connection = Connection.find params[:connection_id]
      connection.rpc
    end

    def torrent_params
      params.require(:torrent)
    end

    def torrent_create_params
      params.require(:filename)
    end

  end
end