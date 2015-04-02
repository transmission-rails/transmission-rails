require 'rails_helper'

RSpec.describe Api::TorrentsController, type: :controller do
  render_views

  before do
    @user = create(:user)
    @connection = create(:connection)
    @torrent = Transmission::Model::Torrent.new([{'id' => 1}], @connection.rpc)
    @torrents = Transmission::Model::Torrent.new([{'id' => 1}, {'id' => 2}], @connection.rpc)
    allow(controller).to(receive(:current_user).and_return(@user))
    allow(Transmission::Model::Torrent).to(receive(:all).and_return(@torrents))
    allow(Transmission::Model::Torrent).to(receive(:find).and_return(@torrent))
    allow(Transmission::Model::Torrent).to(receive(:add).and_return(@torrent))
    allow(@torrent).to(receive(:save!).and_return(nil))
    allow(@torrent).to(receive(:delete!).and_return(nil))
  end

  describe 'GET index' do
    it 'assigns @torrents' do
      get :index, connection_id: @connection.id
      expect(assigns(:torrents)).to eq(@torrents)
    end

    it 'responds successfully' do
      get :index, connection_id: @connection.id
      expect(response.status).to eq(200)
    end

    it 'responds with the correct attributes' do
      get :index, connection_id: @connection.id
      body = JSON.parse response.body
      expect(body).to be_an(Array)
      expect(body.first).to eq({'id' => 1})
    end
  end

  describe 'GET show' do
    it 'assigns @torrent' do
      get :show, connection_id: @connection.id, id: @torrent.id
      expect(assigns(:torrent)).to eq(@torrent)
    end

    it 'responds successfully' do
      get :show, connection_id: @connection.id, id: @torrent.id
      expect(response.status).to eq(200)
    end

    it 'responds with the correct attributes' do
      get :show, connection_id: @connection.id, id: @torrent.id
      body = JSON.parse response.body
      expect(body).to be_a(Hash)
      expect(body).to eq({'id' => 1})
    end
  end

  describe 'PUT update' do
    before :each do
      @torrent_params = {'downloadLimited' => false}
    end

    it 'assigns @torrent' do
      put :update, connection_id: @connection.id, id: @torrent.id, torrent: @torrent_params
      expect(assigns(:torrent)).to eq(@torrent)
    end

    it 'updates @torrent attributes' do
      put :update, connection_id: @connection.id, id: @torrent.id, torrent: @torrent_params
      expect(assigns(:torrent).download_limited).to eq(false)
      expect(assigns(:torrent).attributes['downloadLimited']).to eq(false)
    end

    it 'responds successfully' do
      put :update, connection_id: @connection.id, id: @torrent.id, torrent: @torrent_params
      expect(response.status).to eq(200)
    end

    it 'responds with the correct attributes' do
      put :update, connection_id: @connection.id, id: @torrent.id, torrent: @torrent_params
      body = JSON.parse response.body
      expect(body).to be_a(Hash)
      expect(body).to eq({'id' => 1, 'downloadLimited' => false})
    end
  end

  describe 'POST create' do
    before :each do
      @filename = 'http://example.com/torrent.torrent'
    end

    it 'assigns @torrent' do
      post :create, connection_id: @connection.id, filename: @filename
      expect(assigns(:torrent)).to eq(@torrent)
    end

    it 'responds successfully' do
      post :create, connection_id: @connection.id, filename: @filename
      expect(response.status).to eq(200)
    end

    it 'responds with the correct attributes' do
      post :create, connection_id: @connection.id, filename: @filename
      body = JSON.parse response.body
      expect(body).to be_a(Hash)
      expect(body).to eq({'id' => 1})
    end
  end

  describe 'DELETE destroy' do
    it 'assigns @torrent' do
      delete :destroy, connection_id: @connection.id, id: @torrent.id
      expect(assigns(:torrent)).to eq(@torrent)
    end

    it 'responds successfully' do
      delete :destroy, connection_id: @connection.id, id: @torrent.id
      expect(response.status).to eq(200)
    end
  end

end