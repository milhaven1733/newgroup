require "test_helper"

describe OrderInfo do
  let(:order_info) { OrderInfo.new }

  it "must be valid" do
    order_info.must_be :valid?
  end
end
