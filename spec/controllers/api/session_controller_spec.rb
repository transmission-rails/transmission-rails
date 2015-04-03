require 'rails_helper'

RSpec.describe Api::SessionController, type: :controller do
  render_views

  before do
    @user = create(:user)
    @connection = create(:connection)
    @session = Transmission::Model::Session.new({'id' => 1}, @connection.rpc)
    allow(controller).to(receive(:current_user).and_return(@user))
    allow(Transmission::Model::Session).to(receive(:get).and_return(@session))
    allow(@session).to(receive(:save!).and_return(nil))
  end

  describe 'GET index' do
    it 'assigns @session' do
      get :index, connection_id: @connection.id
      expect(assigns(:session)).to eq(@session)
    end

    it 'responds successfully' do
      get :index, connection_id: @connection.id
      expect(response.status).to eq(200)
    end

    it 'responds with the correct attributes' do
      get :index, connection_id: @connection.id
      body = JSON.parse response.body
      expect(body).to eq({'id' => 1})
    end
  end

  describe 'POST create' do
    it 'assigns @torrent' do
      post :create, connection_id: @connection.id, session: {alt_speed_down: 50}
      expect(assigns(:session)).to eq(@session)
    end

    it 'responds successfully' do
      post :create, connection_id: @connection.id, session: {alt_speed_down: 50}
      expect(response.status).to eq(200)
    end

    it 'responds with the correct attributes' do
      post :create, connection_id: @connection.id, session: {alt_speed_down: 50}
      body = JSON.parse response.body
      expect(body).to eq({'id' => 1, 'alt_speed_down' => '50'})
    end
  end

end