require 'rails_helper'

RSpec.describe Connection, type: :model do
  describe 'validation' do
    describe 'without missing attributes' do
      it 'throws validation error' do
        user = build(:connection, name: nil, host: nil, port: nil, path: nil, ssl: nil)
        expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    describe 'with all attributes' do
      it 'does not throw validation error' do
        user = build(:connection)
        expect { user.save! }.not_to raise_error
      end
    end
  end

  describe '#rpc' do
    it 'returns a valid rpc connector' do
      user = build(:connection)
      expect(user.rpc).to be_a(Transmission::RPC)
    end
  end

end