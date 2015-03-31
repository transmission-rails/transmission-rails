require 'rails_helper'

RSpec.describe Api::ConnectionsController, type: :controller do

  before do
    user = create(:user)
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

  describe 'PUT update' do
    describe 'with valid parameters' do
      before :each do
        @connection = create(:connection)
        @connection_params = {name: 'test', host: 'new.host', path: '/', port: 9091, ssl: true, username: 'username', password: 'password', credentials: true}
      end

      it 'updates @connection' do
        put :update, id: @connection.id, connection: @connection_params
        expect(assigns(:connection).name).to eq('test')
        expect(assigns(:connection).host).to eq('new.host')
        expect(assigns(:connection).port).to eq(9091)
        expect(assigns(:connection).ssl).to eq(true)
        expect(assigns(:connection).username).to eq('username')
        expect(assigns(:connection).password).to eq('password')
        expect(assigns(:connection).credentials).to eq(true)
      end

      it 'renders the index template' do
        put :update, id: @connection.id, connection: @connection_params
        expect(response).to render_template('update')
      end

      it 'responds successfully' do
        put :update, id: @connection.id, connection: @connection_params
        expect(response.status).to eq(200)
      end
    end

    describe 'with invalid parameters' do
      before :each do
        @connection = create(:connection)
        @connection_params = {}
      end

      it 'throws an error' do
        expect {
          put :update, id: @connection.id, connection: @connection_params
        }.to raise_error(ActionController::ParameterMissing)
      end
    end
  end

  describe 'POST create' do
    describe 'with valid parameters' do
      before :each do
        @connection_params = {name: 'test', host: 'new.host', path: '/', port: 9091, ssl: true, username: 'username', password: 'password', credentials: true}
      end

      it 'updates @connection' do
        post :create, connection: @connection_params
        expect(assigns(:connection).name).to eq('test')
        expect(assigns(:connection).host).to eq('new.host')
        expect(assigns(:connection).port).to eq(9091)
        expect(assigns(:connection).ssl).to eq(true)
        expect(assigns(:connection).username).to eq('username')
        expect(assigns(:connection).password).to eq('password')
        expect(assigns(:connection).credentials).to eq(true)
      end

      it 'renders the index template' do
        post :create, connection: @connection_params
        expect(response).to render_template('create')
      end

      it 'responds successfully' do
        post :create, connection: @connection_params
        expect(response.status).to eq(201)
      end
    end

    describe 'with invalid parameters' do
      before :each do
        @connection = create(:connection)
        @connection_params = {}
      end

      it 'throws an error' do
        expect {
          post :create, connection: @connection_params
        }.to raise_error(ActionController::ParameterMissing)
      end
    end
  end

  describe 'DELETE destroy' do
    describe 'with valid parameters' do
      before :each do
        @connection = create(:connection)
      end

      it 'deletes @connection' do
        delete :destroy, id: @connection.id
        expect {
          Connection.find @connection.id
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'renders the index template' do
        delete :destroy, id: @connection.id
        expect(response).to render_template('destroy')
      end

      it 'responds successfully' do
        delete :destroy, id: @connection.id
        expect(response.status).to eq(200)
      end
    end
  end
end