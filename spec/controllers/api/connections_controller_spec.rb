require 'rails_helper'

RSpec.describe Api::ConnectionsController, type: :controller do

  before do
    allow(controller).to(receive(:current_user).and_return(user))
  end

  describe 'GET index' do
    it 'assigns @connections' do
      connection = create(:connection)
      get :index
      expect(assigns(:connections)).to eq([connection])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'responds successfully' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'GET show' do
    before :each do
      @connection = create(:connection)
    end

    it 'assigns @connection' do
      get :show, id: @connection.id
      expect(assigns(:connection)).to eq(@connection)
    end

    it 'renders the index template' do
      get :show, id: @connection.id
      expect(response).to render_template('show')
    end

    it 'responds successfully' do
      get :show, id: @connection.id
      expect(response.status).to eq(200)
    end
  end
end