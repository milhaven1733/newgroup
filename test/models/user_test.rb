require 'test_helper'

describe User do
  let(:user) { create(:user) }

  it 'should init wallet when create user' do
    assert user.reload.wallet.is_a?(Wallet)
    assert_equal 0, user.reload.wallet.balance
  end

  it "should set default role as normal" do
    assert_equal 'normal', user.role
  end

  it "should set role as merchant" do
    user = create(:user, role: :merchant)
    assert_equal 'merchant', user.role
  end
end