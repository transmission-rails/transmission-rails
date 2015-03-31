require 'rails_helper'

RSpec.describe ApiController, type: :controller do
  describe '#authenticate' do
    describe 'when valid credentials' do
      before :each do
        create(:user, username: 'username', password: 'password')
      end

      it 'should set current_user' do
        controller.request.env['HTTP_AUTHORIZATION'] =
            ActionController::HttpAuthentication::Basic.encode_credentials('username', 'password')
        controller.authenticate
        expect(controller.current_user).to be_a(User)
      end
    end

    describe 'with invalid credentials' do
      before :each do
        create(:user, username: 'username', password: 'password')
      end

      it 'should not set current_user' do
        controller.request.env['HTTP_AUTHORIZATION'] =
            ActionController::HttpAuthentication::Basic.encode_credentials('wrong', 'wrong')
        controller.authenticate
        expect(controller.current_user).to eq(nil)
      end
    end
  end

  describe '#check_auth' do
    describe 'with current_user' do
      before :each do
        user = build(:user)
        allow(controller).to(receive(:current_user).and_return(user))
      end

      it 'does not throw an error' do
        expect { controller.check_auth }.not_to raise_error
      end
    end

    describe 'without current_user' do
      before :each do
        allow(controller).to(receive(:current_user).and_return(nil))
      end

      it 'throws an error' do
        expect { controller.check_auth }.to raise_error(ApiController::UnauthorizedError)
      end
    end
  end
end