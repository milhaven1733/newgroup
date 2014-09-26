require 'test_helper'

require 'test_helper'

describe Ticket do
  let(:user) { create(:user) }
  let(:ticket) { create(:ticket) }

  it 'price_when should return origin price when missing group price' do
    assert_equal ticket.oprice, ticket.price_when(10)
  end

  it 'price_when should return price' do
    create(:group_price, ticket: ticket, price: 4, range_from: 5, range_to: 10)
    assert_equal 4.0, ticket.price_when(10)
  end

  it 'price_when should return price when range_to is nil' do
    create(:group_price, ticket: ticket, price: 4, range_from: 5)
    assert_equal 4.0, ticket.price_when(10)
  end

  it "price_when should return price for student" do
    student_ticket = create(:ticket, student_discount: 50)
    create(:group_price, ticket: student_ticket, price: 4, range_from: 5)
    assert_equal 2.0, student_ticket.price_when(10, true)
  end
end