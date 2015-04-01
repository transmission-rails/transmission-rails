require 'transmission'

module Api
  class TorrentsController < ApiController

    def index
      @torrents = Transmission::Model::Torrent.all connector: rpc_client
      render json: torrents_json(@torrents)
    end

    def show
      @torrent = Transmission::Model::Torrent.find params[:id].to_i, connector: rpc_client
      render json: @torrent.attributes
    end

    def update
      @torrent = Transmission::Model::Torrent.find params[:id].to_i, connector: rpc_client
      @torrent.attributes = @torrent.attributes.merge(torrent_params)
      @torrent.save!
      render json: @torrent.attributes
    end

    def create
      arguments = {'filename' => torrent_create_params}
      @torrent = Transmission::Model::Torrent.add arguments: arguments, connector: rpc_client
      render json: @torrent.attributes
    end

    def destroy
      @torrent = Transmission::Model::Torrent.find params[:id].to_i, connector: rpc_client
      @torrent.delete!
      render json: @torrent.attributes
    end

    private

    def rpc_client
      connection = Connection.find params[:connection_id]
      connection.rpc
    end

    def torrents_json(torrents)
      torrents.inject([]) do |result, torrent|
        result << torrent.attributes
      end
    end

    def torrent_params
      params.require(:torrent)
    end

    def torrent_create_params
      params.require(:filename)
    end

  end
end