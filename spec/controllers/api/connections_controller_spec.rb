require 'rails_helper'

RSpec.describe Api::ConnectionsController, type: :controller do
  let(:user) { User.new }

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
end