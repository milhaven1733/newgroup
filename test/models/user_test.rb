require 'test_helper'

describe User do
  let(:user) { create(:user) }

  it 'should init wallet when create user' do
    assert user.reload.wallet.is_a?(Wallet)
    assert_equal 0, user.reload.wallet.balance
  end
end
