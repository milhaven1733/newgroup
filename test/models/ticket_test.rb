require 'test_helper'

require 'test_helper'

describe Ticket do
  let(:user) { create(:user) }
  let(:ticket) { create(:ticket) }

  it 'price_when should return nil when missing group price' do
    assert_equal nil, ticket.price_when(10)
  end

  it 'price_when should return price' do
    create(:group_price, ticket: ticket, price: 4, range_from: 5, range_to: 10)
    assert_equal 4.0, ticket.price_when(10)
  end

  it 'price_when should return price when range_to is nil' do
    create(:group_price, ticket: ticket, price: 4, range_from: 5)
    assert_equal 4.0, ticket.price_when(10)
  end
end
