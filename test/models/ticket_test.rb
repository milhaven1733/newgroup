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
  
  it "Ticket time range should invalid" do
    invalide_ticket = create(:ticket, start_at: DateTime.now, 
                           end_at: (DateTime.now - 1.day))
    assert_equal "Invalid ticket time range, Please contact merchant administrator!",
      invalide_ticket.time_range
  end
  
  it "should return time range" do
    valide_ticket = create(:ticket, start_at: DateTime.new(2014,11,20,8,0),
                        end_at: DateTime.new(2014,11,20,10,0))
    assert_equal "11/20/2014\n08:00 AM - 10:00 AM", valide_ticket.time_range
  end
end