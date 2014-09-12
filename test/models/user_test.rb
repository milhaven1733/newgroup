require 'test_helper'

describe User do
  let(:user) { create(:user) }

  it 'should init wallet when create user' do
    assert user.reload.wallet.is_a?(Wallet)
    assert_equal 0, user.reload.wallet.balance
  end

  it "student should register with .edu email" do
    ex = assert_raises(ActiveRecord::RecordInvalid) { create(:user, is_student: true) }
    assert ex.message.include?("Email student account must regirster with .edu email"), "Error message should right"
    assert_nothing_raised { create(:user, email: 'example@test.edu', is_student: true) }
  end
end
