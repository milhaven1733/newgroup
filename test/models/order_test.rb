require 'test_helper'

describe Order do
  let(:user) { create(:user) }
  let(:ticket) { create(:ticket, amount: 100) }

  it 'pay_by should update ticket amount & wallet balance & order status' do
    wallet = user.wallet
    wallet.update balance: 100
    order = create(:order, ticket: ticket, user: user, price: 1, count: 5)

    assert_equal 'created', order.reload.status
    assert_equal 100, ticket.reload.amount
    assert_equal 100.0, wallet.reload.balance

    order.pay_by user

    assert_equal 'paid', order.reload.status
    assert_equal 95, ticket.reload.amount
    assert_equal 95.0, wallet.reload.balance
  end
end