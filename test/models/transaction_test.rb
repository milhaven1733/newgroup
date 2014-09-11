require 'test_helper'

describe Transaction do
  let(:user) { create(:user) }

  it 'update wallet when missing wallet' do
    t = create(:transaction, user: user)
    user.wallet.destroy

    e = assert_raises(RuntimeError) do
      t.reload.update status: 'success'
    end
    assert_equal 'missing according wallet', e.message
  end

  it 'update wallet when recharge' do
    t = create(:transaction, user: user, transaction_type: :recharge, dollar: 2)
    assert_equal 0, t.user.reload.balance
    t.update status: 'success'
    assert_equal 2.0, t.user.reload.balance
  end

  it 'update wallet when withdraw > balance' do
    t = create(:transaction, user: user, transaction_type: :withdraw, dollar: 2)
    assert_equal 0, t.user.reload.balance
    e = assert_raises(RuntimeError) do
      t.reload.update status: 'success'
    end
    assert_equal 'Balance less than withdraw amount', e.message
  end

  it 'update wallet when withdraw' do
    user.wallet.update balance: 10
    assert_equal 10.0, user.reload.balance
    t = create(:transaction, user: user, transaction_type: :withdraw, dollar: 2)
    t.reload.update status: 'success'
    assert_equal 8.0, user.reload.balance
  end

end
