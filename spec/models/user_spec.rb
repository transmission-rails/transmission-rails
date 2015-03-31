require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    describe 'without missing attributes' do
      it 'throws validation error' do
        user = build(:user, name: nil, username: nil, email: nil, password: nil)
        expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    describe 'with all attributes' do
      it 'does not throw validation error' do
        user = build(:user, name: 'name', email: 'test@test.com', username: 'test', password: 'password')
        expect { user.save! }.not_to raise_error
      end
    end

    describe 'with invalid email' do
      it 'throws validation error' do
        user = build(:user, email: 'wrong-format')
        expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    describe 'with valid email' do
      it 'does not throw validation error' do
        user = build(:user, email: 'right@email.com')
        expect { user.save! }.not_to raise_error
      end
    end

    describe 'with already existing attributes' do
      it 'throws validation error' do
        create(:user, username: 'unique', email: 'unique@email.com')
        user = build(:user, username: 'unique', email: 'unique@email.com')
        expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe '#password=' do
    it 'will change password' do
      user = build(:user)
      user.password = 'new password'
      expect(user.password).to eq('new password')
    end
  end

  describe '.authenticate!' do
    before :each do
      @user = create(:user, username: 'username', password: 'password')
    end

    describe 'with valid credentials' do
      it 'authenticates the user' do
        expect(User.authenticate!('username', 'password')).to eq(@user)
      end
    end

    describe 'with invalid credentials' do
      it 'does not authenticate the user' do
        expect(User.authenticate!('wrong', 'wrong')).to eq(nil)
      end
    end
  end

end