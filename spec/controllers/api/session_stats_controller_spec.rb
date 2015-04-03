require 'rails_helper'

RSpec.describe Api::SessionStatsController, type: :controller do
  render_views

  before do
    @user = create(:user)
    @connection = create(:connection)
    @session_stats = Transmission::Model::SessionStats.new({'id' => 1}, @connection.rpc)
    allow(controller).to(receive(:current_user).and_return(@user))
    allow(Transmission::Model::SessionStats).to(receive(:get).and_return(@session_stats))
  end

  describe 'GET index' do
    it 'assigns @session' do
      get :index, connection_id: @connection.id
      expect(assigns(:session_stats)).to eq(@session_stats)
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

end